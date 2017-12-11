library(stringr)
 setwd("D:/CBA/DV Assihnment1/assignmentData")


fl<- list.files(pattern = "\\.html$")
library(rvest)

details<- data.frame(indx= character(),Title=character(),Address=character(),phone=character(),website = character(),WorkingHours = character(),Takes_Reservations=character(),Delivery=character(),Take_out=character(),Accepts_Credit_Cards = character(),Accepts_Apple_Pay = character(),Accepts_Android_Pay=character(),Accepts_Bitcoin=character(),Good_For=character(),Parking = character(),Bike_Parking = character(),Good_for_Kids=character(),Good_for_Groups=character(),Attire=character(),Ambience = character(),Noise_Level = character(),Alcohol = character(),Outdoor_Seating=character(),Wi_Fi = character(),Has_TV = character(),Good_for_Kids=character(),Caters = character(),Gender_Neutral_Restrooms = character(),CustomerPage = character(),customerCareEmail=character())
CustomerEmail<- "NA"
ContactPage<-"NA"
for(f in fl)
{

  pageSrc<- read_html(f)
  #get HEader Name
  htNode = html_node(pageSrc,".biz-page-title")
  restName = html_text(htNode)
  if(is.na(restName) )
  {
    restName = "NA"
  }else
  {
  restName <- gsub(pattern = "\n",replacement = "",x = restName,fixed = TRUE)
  }

 # get Address
  htNode = html_node(pageSrc,"address")
  Address = html_text(htNode)
  if(is.na(Address) )
  {
    Address = "NA"
  }else
  {
  Address <- gsub(pattern = "\n",replacement = "",x = Address,fixed = TRUE)
  }

  #get Phone number

  htNode = html_node(pageSrc,".biz-phone")
  Phone = html_text(htNode)
  if(is.na(Phone))
  {
    Phone = "NA"
  }else
  {
  Phone <- gsub(pattern = "\n",replacement = "",x = Phone,fixed = TRUE)
  }

  htNode = html_nodes(pageSrc,xpath = '//*[@id="super-container"]/div/div/div[2]/div[2]/div[1]/table')

  WorkingHours  = html_table(htNode,fill = TRUE)
  if(length(WorkingHours) ==0)
  {
    openingDays = "NA"
  }else
  {
    WorkingHours = as.data.frame(WorkingHours[[1]])
    cd <- paste(WorkingHours$X1,WorkingHours$X2,sep = " , ")
    openingDays =""
    for(i in c(1:7))
    {
      openingDays = paste(openingDays, cd[i],collapse = ".")
    }
  }


  htNode = html_nodes(pageSrc,".ylist .attribute-key")
  InforArrTopic = html_text(htNode)
  fnrmvLine<- function(x)
  {
    x<- gsub("\n","",x,FALSE)
    return(x)

  }

  for(i in 1:length(InforArrTopic))
  {
    InforArrTopic[i]<- fnrmvLine(InforArrTopic[i])
  }

  htNode = html_nodes(pageSrc,".ylist dd")
  InforArrResponse = html_text(htNode)

  for(i in 1:length(InforArrResponse))
  {
    InforArrResponse[i]<- fnrmvLine(InforArrResponse[i])
  }

  InforArrTopic<- str_trim(InforArrTopic)

  InforArrResponse<- str_trim(InforArrResponse)
  getResponse<- function(sString,sVecorTopic, sVectoeResponse)
  {
    ind<- sString %in% sVecorTopic
    if(ind)
    {
      ind<- which(sVecorTopic==sString)
      return(sVectoeResponse[ind])
    }else
    {
      return("NA")
    }
  }


  Takes_Reservations<- getResponse("Takes Reservations",InforArrTopic,InforArrResponse)
  Delivery<- getResponse("Delivery",InforArrTopic,InforArrResponse)
  Take_out<- getResponse("Take-out",InforArrTopic,InforArrResponse)
  Accepts_Credit_Cards<- getResponse("Accepts Credit Cards",InforArrTopic,InforArrResponse)
  Accepts_Apple_Pay<- getResponse("Accepts Apple Pay",InforArrTopic,InforArrResponse)
  Accepts_Android_Pay<- getResponse("Accepts Android Pay",InforArrTopic,InforArrResponse)
  Accepts_Bitcoin<- getResponse("Accepts Bitcoin",InforArrTopic,InforArrResponse)
  Good_For<- getResponse("Good For",InforArrTopic,InforArrResponse)
  Parking<- getResponse("Parking",InforArrTopic,InforArrResponse)
  Bike_Parking<- getResponse("Bike Parking",InforArrTopic,InforArrResponse)
  Good_for_Kids<- getResponse("Good for Kids",InforArrTopic,InforArrResponse)
  Good_for_Groups<- getResponse("Good for Groups",InforArrTopic,InforArrResponse)
  Attire<- getResponse("Attire",InforArrTopic,InforArrResponse)
  Ambience<- getResponse("Ambience",InforArrTopic,InforArrResponse)
  Noise_Level<- getResponse("Noise Level",InforArrTopic,InforArrResponse)
  Alcohol<- getResponse("Alcohol",InforArrTopic,InforArrResponse)
  Outdoor_Seating<- getResponse("Outdoor Seating",InforArrTopic,InforArrResponse)
  Wi_Fi<- getResponse("Wi-Fi",InforArrTopic,InforArrResponse)
  Has_TV<- getResponse("Has TV",InforArrTopic,InforArrResponse)
  Good_for_Kids<- getResponse("Good for Kids",InforArrTopic,InforArrResponse)
  Caters<- getResponse("Caters",InforArrTopic,InforArrResponse)
  Gender_Neutral_Restrooms<- getResponse("Gender Neutral Restrooms",InforArrTopic,InforArrResponse)




  #get website

  htNode = html_node(pageSrc,".biz-website a")
  webSite = html_text(htNode)

  if(is.na(webSite))
  {
    webSite = "NA"
  }else
  {

    webSite = paste("http://",trimws(webSite),sep = "")
    newpage=read_html(webSite)


    linkText<- newpage%>%html_nodes("a")%>%html_attr("href")
      for(i in c(1:length(linkText)))
        {
          res<- grep(pattern ="contact",linkText[i],ignore.case = TRUE)
          res<-   ifelse(length(res)==0,0,1)
          if (res==1)
            {

              blnFlag =TRUE

              for(j in c(1:length(linkText)))
              {
                res<- grep(pattern ="mailto",linkText[j],ignore.case = TRUE)
                res<-   ifelse(length(res)==0,0,1)
                if (res==1)
                  {
                    CustomerEmail<- linkText[j]
                    break()
                  }
                }
                break()

              }

            }
            if (blnFlag==TRUE)
              {
                res<- grep(pattern =".com",linkText[i],ignore.case = TRUE)
                res<-   ifelse(length(res)==0,0,1)
                if (res==0)
                  {
                    ContactPage <- paste(webSite,linkText[i], sep="")

                  }else
                  {
                    ContactPage<- linkText[i]
                  }


                  }else
                  {
                    ContactPage = "NA"
                  }
    }

                newpage = NULL
                detailsadd<- data.frame(restName,Address,Phone,webSite,openingDays,Takes_Reservations,Delivery,Take_out,Accepts_Credit_Cards,Accepts_Apple_Pay,Accepts_Android_Pay,Accepts_Bitcoin,Good_For,Parking,Bike_Parking,Good_for_Kids,Good_for_Groups,Attire,Ambience,Noise_Level,Alcohol,Outdoor_Seating,Wi_Fi,Has_TV,Good_for_Kids,Caters,Gender_Neutral_Restrooms,ContactPage,CustomerEmail)
                
                details<- rbind(details,detailsadd)
                newpage = NULL
                CustomerEmail<- "NA"
                ContactPage<-"NA"




}

 write.table(details,"details6.txt",sep = "\t",)


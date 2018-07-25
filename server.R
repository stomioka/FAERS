#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny);library(openfda);library(ggplot2);library(DT);

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
######reactions
  output$table1 <- renderDataTable({ 
    drug<-input$drug1
    metric<-"patient.reaction.reactionmeddrapt.exact"
    ss<-input$sex1
    
    sex <- fda_query("/drug/event.json") %>%
      fda_filter("patient.drug.openfda.generic_name",drug ) %>%
      fda_filter("patient.drug.drugcharacterization", "1") %>% #1=Suspect, (the drug was considered by the reporter to have interacted with the suspect drug)
      fda_count("patient.patientsex") %>%
      fda_limit(1000) %>%
      fda_exec()
    #sex[,1] <-sub(1,"Male", sex[,1])
    #sex[,1] <-sub(2,"Female", sex[,1]) 
    #sex[,1] <-sub(0,"Unknown", sex[,1])
    names(sex)<-c("sex","sex_count")
    
    #reaction by sex
    for(i in 1:3){
      tmp<- fda_query("/drug/event.json") %>%
        fda_filter("patient.patientsex", as.character(sex$sex[i])) %>%
        fda_filter("patient.drug.drugcharacterization", "1") %>%
        fda_filter("patient.drug.openfda.generic_name", drug) %>%
        fda_count(metric) %>%
        fda_limit(1000) %>%
        fda_exec()
      tmp$sex <- i
      if(i==1){
        outtbl  <- tmp
      } else {
        outtbl  <- rbind(outtbl,tmp)
        
      }
    }
    outtbl[,3] <-sub(1,"Male", outtbl[,3])
    outtbl[,3] <-sub(2,"Female", outtbl[,3]) 
    outtbl[,3] <-sub(0,"Unknown", outtbl[,3])
    outtbl[outtbl$sex==ss,] 
  })
  

  
######indication
  output$table2 <- renderDataTable({ 

      drug<-input$drug2
      metric<-"patient.drug.drugindication.exact"
      ss<-input$sex2
      
      sex <- fda_query("/drug/event.json") %>%
        fda_filter("patient.drug.openfda.generic_name",drug ) %>%
        fda_filter("patient.drug.drugcharacterization", "1") %>% #1=Suspect, (the drug was considered by the reporter to have interacted with the suspect drug)
        fda_count("patient.patientsex") %>%
        fda_limit(1000) %>%
        fda_exec()
      #sex[,1] <-sub(1,"Male", sex[,1])
      #sex[,1] <-sub(2,"Female", sex[,1]) 
      #sex[,1] <-sub(0,"Unknown", sex[,1])
      names(sex)<-c("sex","sex_count")
      
      #reaction by sex
      for(i in 1:3){
        tmp<- fda_query("/drug/event.json") %>%
          fda_filter("patient.patientsex", as.character(sex$sex[i])) %>%
          fda_filter("patient.drug.drugcharacterization", "1") %>%
          fda_filter("patient.drug.openfda.generic_name", drug) %>%
          fda_count(metric) %>%
          fda_limit(1000) %>%
          fda_exec()
        tmp$sex <- i
        if(i==1){
          outtbl  <- tmp
        } else {
          outtbl  <- rbind(outtbl,tmp)
          
        }
      }
      outtbl[,3] <-sub(1,"Male", outtbl[,3])
      outtbl[,3] <-sub(2,"Female", outtbl[,3]) 
      outtbl[,3] <-sub(0,"Unknown", outtbl[,3])
      outtbl[outtbl$sex==ss,] 
    })
  
###Death
  ######indication
  output$plot1 <- renderPlot({ 
    
    drug<-input$drug3
    metric<-"seriousnessdeath"

    
    sex <- fda_query("/drug/event.json") %>%
      fda_filter("patient.drug.openfda.generic_name",drug ) %>%
      fda_filter("patient.drug.drugcharacterization", "1") %>% #1=Suspect, (the drug was considered by the reporter to have interacted with the suspect drug)
      fda_count("patient.patientsex") %>%
      fda_limit(1000) %>%
      fda_exec()
    #sex[,1] <-sub(1,"Male", sex[,1])
    #sex[,1] <-sub(2,"Female", sex[,1]) 
    #sex[,1] <-sub(0,"Unknown", sex[,1])
    names(sex)<-c("sex","sex_count")
    
    #reaction by sex
    for(i in 1:2){
      tmp<- fda_query("/drug/event.json") %>%
        fda_filter("patient.patientsex", as.character(i)) %>%
        fda_filter("patient.drug.drugcharacterization", "1") %>%
        fda_filter("patient.drug.openfda.generic_name", drug) %>%
        fda_count(metric) %>%
        fda_limit(1000) %>%
        fda_exec()
      tmp$sex <- i
      if(i==1){
        outtbl  <- tmp
      } else {
        outtbl  <- rbind(outtbl,tmp)
        
      }
    }
    outtbl[,3] <-sub(1,"Male", outtbl[,3])
    outtbl[,3] <-sub(2,"Female", outtbl[,3]) 
    outtbl[,3] <-sub(0,"Unknown", outtbl[,3])
    tcount<-outtbl$count[1]+outtbl$count[2]
    ggplot(data=outtbl, aes(x=sex, y=count,color=sex))+
      geom_bar(fill="white", stat="identity")+ guides(fill=FALSE) + theme_minimal()+
      labs(title=paste("Reported SAE resulted in death by taking",drug), subtitle=paste("Total:",tcount, " death"))
    
  })
  
#########
  output$plot2 <- renderPlot({
    
    drug<-input$drug4
    metric<-"patient.patientonsetage"
    
    ageu <- fda_query("/drug/event.json") %>%
      fda_filter("patient.drug.openfda.generic_name",drug) %>%
      fda_filter("patient.drug.drugcharacterization", "1") %>% #1=Suspect, #2 Conmeds, #3 Interacting (the drug was considered by the reporter to have interacted with the suspect drug)
      fda_count("patient.patientonsetageunit")  %>%
      fda_limit(1000) %>%
      fda_exec()
    for(i in 800:802){
      for(j in 1:2){
      tmp<- fda_query("/drug/event.json") %>%
        fda_filter("patient.patientsex", j) %>%
        fda_filter("patient.patientonsetageunit", as.character(i)) %>%
        fda_filter("patient.drug.drugcharacterization", "1") %>%
        fda_filter("patient.drug.openfda.generic_name", drug) %>%
        fda_count(metric) %>%
        fda_limit(1000) %>%
        fda_exec()
      tmp$unit <- i
      tmp$sex <- j
      if(i==800){
        age  <- tmp
      } else {
        age  <- rbind(age,tmp)
        
      }
    }}
    age$conv <-as.numeric(sub(800,10, age[,3]) )#decase
    age$conv <-as.numeric(sub(801,1, age$conv) ) #year
    age$conv <-as.numeric(sub(802,1/12, age$conv)) #month
    age$conv <-as.numeric(sub(803,1/(365.25/7),age$conv)) #week
    age$conv <-as.numeric(sub(804,1/365.25, age$conv)) #days
    age$conv <-as.numeric(sub(805,1/8766, age$conv)) #hour
    age$age <-round(age$term * (age$conv),2)
    age$sex <-sub(1,"Male",  age$sex)
    age$sex  <-sub(2,"Female",  age$sex) 

    ggplot(data=age, aes(x=age, y=count,color=sex))+scale_x_continuous(limits = c(0,100)) +
      geom_bar(fill="white", stat="identity")+ guides(fill=FALSE) + theme_minimal()+
      labs(title=paste("Age (year) distribution of subjects taking",drug), subtitle="Age provided in week, days, and hours are ignored.")
})
  
})



      program plottest 
! This version includes the interface. It cannot be compiled by g77.
        include '../interface.f90'
!                                                                       
! Illustrative test program that exercises most low level routines.     
! Various working variables.                                            
      integer length 
      parameter (length=100) 
      real x(length),y(length),err(length),ym(length) 
      integer i,irows,icolumns,itype 
                                                                        
! Make test arrays.                                                     
      do 2 i=1,length 
         x(i)=float(i)*1. 
         y(i)=1.*(1.4+sin(0.2*x(i))) 
         err(i)=0.4*sin(x(i)*sin(x(i))) 
         ym(i)=y(i)-0.5*err(i) 
    2 continue 
                                                                        
! Plot 1. Simplest one-call plot.                                       
      call autoplot(x,y,length) 
! If needed other calls can overwrite before terminating via:           
      call pltend() 
                                                                        
! Plot 2. A more complicated plot to illustrate different possibilities.
! Initialize the plot:                                                  
      call pltinit(1.,float(length),0.,2.) 
! Draw the axes                                                         
      call axis() 
! Label them if you like.                                               
      call axlabels('X-axis','Y-axis') 
! And put a title on the box                                            
      call boxtitle('Test Plot') 
! Example of a color set, 0:invisible, 1-7:dim, 8-15 bright:            
      call color(12) 
! Drawing a line exceeding the screen size, is not recommended but      
! is safe because clipped automatically:                                
      call polyline(x,y,length) 
! Return to default, bright black(!).                                   
      call color(15) 
! Set software truncation to a specified normal-units region;           
      call truncf(.5,.85,.3,.5) 
! Draw the line again. Only sections in the truncation region are overdr
      call polyline(x,y,length) 
! Switch off truncation.                                                
      call truncf(0.,0.,0.,0.) 
      call pltend 
                                                                        
! Plot 3.                                                               
! Use the built in response facility by calling with negative switch.   
! This will prompt for plotting to file.                                
!      call pfset(-3)                                                   
      call pfset(3) 
! Set to dashed line plotting, only polylines are dashed:               
      call dashset(2) 
! Do a log autoplot of the arrays. x logarithmic, y linear.             
      call lautoplot(x,y,length,.true.,.false.) 
! Label the axes using different fonts.                                 
      call axlabels('X-axis !Alabel!@ back','Y-!Baxis!A label') 
! Overplot markers (6:stars) on the middle half of the points,          
! not dashed because doesn't use polyline.                              
      call polymark(x(length/4),y(length/4),length/2,6) 
! Set back to solid lines:                                              
      call dashset(0) 
! To illustrate a more general drawstring, draw a title, justified cente
! (All strings drawn in normal units.)                                  
! Make the characters .02 in size. (width,height)                       
      call charsize(.02,.02) 
      call jdrwstr(0.65,0.72,' TITLE OF PLOT',0.) 
! Restore default size.                                                 
      call charsize(0.,0.) 
      call pltend() 
! Switch off plotting to file.                                          
!      call pfset(0)                                                    
!                                                                       
! Plot 4 Simple log-log plot.                                           
! But with reversed tics and axes                                       
      call ticrev 
! Make the axis point at the top right. Arguments are fractions of axreg
      call axptset(1.,1.) 
        call dashset(4) 
      call lautoplot(x,y,length,.true.,.true.) 
        call dashset(0) 
      call axptset(0.,0.) 
      call ticrev 
! Draw additional axes in standard position, illustrating first,delta.  
      call xaxis(5.,1.) 
      call yaxis(3.,10.) 
      call pltend 
!                                                                       
      call togminor() 
! Plot 5 Simplest automatic scatter plot                                
! Illustrating the use of a general character as the marker.            
        call automark(x,y,length,ichar('m')) 
! Overplot some error bars.                                             
        call polyerrs(x,y,err,length,.5,1.) 
        call pltend 
!                                                                       
! Plot 6 Multiple Frame Plot                                            
! (nrows,ncolumns,multype: x,y plot space from bits 0 and 1)            
!       write(*,*)' Enter nrows and ncolumns,itype'                     
!       read(*,*)irows,icolumns,itype                                   
        irows=3 
        icolumns=4 
        itype=3 
        call multiframe(irows,icolumns,itype) 
        do 10 i=1,irows*icolumns 
           if((i/2)*2.ne.i)then 
              call autoplot(x,y,length) 
           else 
              call autoplot(x,ym,length) 
           endif 
   10   continue 
        call pltend 
                                                                        
      END                                           

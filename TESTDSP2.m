clc
clear all
dt=0.01;
t=-5:dt:5;
u = heaviside(t);



writeobj = VideoWriter('convfinal','Uncompressed AVI');
open(writeobj);

fig1=figure('Renderer', 'painters', 'Position', [280 80 900 600]);


for ii=1:1:5
x=5;
if ii==2
    %% signal 2
    y = exp(-2*t).*u;
    y1 = exp(-4*t).*u;
elseif ii==3
    %% signal 3
    y = exp(-2*t).*u;
    y1 = heaviside(t+1)-heaviside(t-1);
elseif ii==4
    %% signal 4
    y = heaviside(t+1)-heaviside(t-1);
    y1 = heaviside(t+0.5)-heaviside(t-0.5);
elseif ii==5
    %signal 5
    for j=1:1:length(t)
        if t(j)>0
            y(j)=abs(sin(8.*t(j)));
        else
            y(j)=0;
        end
    end
    y1 = exp(-4*t).*u;

elseif ii==1
    %signal 1
    y = exp(-2*t).*u;
    y1=t==0;
elseif ii==6
    %signal 6
    y = 0.5*(t.^2);
    y1 = -0.5*(t.^2);
end

    C1 = dt*conv(y, y1,'same');
    C1_x1=(1:length(C1)).*dt;
    C1_x=((C1_x1-0.01).*(10/20))-5;

    
    subplot(2,1,1);
    
    plot(t,y,'LineWidth',2,'Color',"w");
    curve0=animatedline('LineWidth',2,'Color',"c");
    % lh = legend('f(t)','g(-t)');
    lh = legend('\color{white} f(t)','\color{magenta} g(-t)');
    set( lh, 'Box', 'off', 'Color', [0,0,0], 'EdgeColor', get( lh, 'Color' )) ;
    %fontsize(lh,14,'points')
    set(lh,'Location','best','NumColumns',2,'FontSize',12);
    %set(lgnd,'color','none');
   
    title('Convoluion of Two Signals-Developed by Dr.M.Kaliamoorthy');
    if ii==2
        t1 = '$f(t)=e^{-2t}u(t)$ and $g(t)=e^{-4t}u(t)$';
        set(gca,'XLim',[-5 5], 'Ylim',[0 1.2], 'Color','k');
        subtitle(t1,'interpreter','latex');
    elseif ii==3
        t1 = '$f(t)=e^{-2t}u(t)$ and $g(t)=u(t+1)-u(t-1)$';
        set(gca,'XLim',[-5 5], 'Ylim',[0 1.2], 'Color','k');
        
        subtitle(t1,'interpreter','latex');
    elseif ii==4
        t1 = '$f(t)=u(t+1)-u(t-1)$ and $g(t)=u(t+0.5)-u(t-0.5)$';
        set(gca,'XLim',[-5 5], 'Ylim',[0 1.2], 'Color','k');
        subtitle(t1,'interpreter','latex');
    elseif ii==5
        t1 = '$f(t)=\mid sin(8t)\mid$ and $g(t)=e^{-4t}u(t)$';
        set(gca,'XLim',[-5 5], 'Ylim',[0 1.2], 'Color','k');
        subtitle(t1,'interpreter','latex');
    elseif ii==1
        t1 = '$f(t)=e^{-2t}u(t)$ and $g(t)=\delta (t) $';
        set(gca,'XLim',[-5 5], 'Ylim',[0 1.2], 'Color','k');
        subtitle(t1,'interpreter','latex');
    elseif ii==6
        t1 = '$f(t)=0.1t^2$ and $g(t)=-0.1t^2 $';
        set(gca,'XLim',[-5 5], 'Ylim',[-1 1], 'Color','k');
        subtitle(t1,'interpreter','latex');
    end

    subplot(2,1,2)
    curve1=animatedline('LineWidth',2,'Color',"r");
    if ii==2
        set(gca,'XLim',[-5 5], 'Ylim',[-0.05 0.2], 'Color','k');
    elseif ii==3
        set(gca,'XLim',[-5 5], 'Ylim',[-0.05 0.6], 'Color','k');
    elseif ii==4
        set(gca,'XLim',[-5 5], 'Ylim',[-0.05 1.2], 'Color','k');
    elseif ii==5
       set(gca,'XLim',[-5 5], 'Ylim',[-0.05 0.2], 'Color','k');
    elseif ii==1
       set(gca,'XLim',[-5 5], 'Ylim',[-0.001 0.01], 'Color','k'); 
    elseif ii==6
       set(gca,'XLim',[-5 5], 'Ylim',[-500 1], 'Color','k'); 
    end
    
    title('Convoluion of f(t)*g(t)');
    

    for i=1:5:length(t)
        clearpoints(curve0)
        % 
        X11 = t+x;
        X1 = fliplr(X11*-1);
        Y11 = y1;
        Y1 = fliplr(Y11);
        addpoints(curve0,X1,Y1);
        addpoints(curve1,t(i),C1(i));
        x=x-0.05;
        drawnow
        currFrame=getframe(fig1);
        writeVideo(writeobj, currFrame)
    
    end
   
    if ii ~= 5
    clearpoints(curve1)
    end
end
close(writeobj)



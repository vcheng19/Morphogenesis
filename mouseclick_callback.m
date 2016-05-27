function junk = mouseclick_callback(cP)
      % the arguments are not important here, they are simply required for
      % a callback function. we don't even use them in the function,
      % but Matlab will provide them to our function, we we have to
      % include them.
      %
      % first we get the point that was clicked on
      x = cP(1,1);
      y = cP(1,2);
      cursor_handle = plot(0,0,'r+ ','visible','off');
      % Now we find out which mouse button was clicked, and whether a
      % keyboard modifier was used, e.g. shift or ctrl
      switch get(gcf,'SelectionType')
          case 'normal' % Click left mouse button.
              s = sprintf('left: (%1.4g, %1.4g)',x,y);
          case 'alt'    % Control - click left mouse button or click right mouse button.
              s = sprintf('right: (%1.4g, %1.4g)',x,y);
          case 'extend' % Shift - click left mouse button or click both left and right mouse buttons.
              s = sprintf('2-click: (%1.4g, %1.4g)',x,y);
          case 'open'   % Double-click any mouse button.
              s = sprintf('double click: (%1.4g, %1.4g)',x,y);
      end
      % get and set title handle
      thandle = get(gca,'Title');
      set(thandle,'String',s);
      % finally change the position of our red plus, and make it
      % visible.
      set(cursor_handle,'Xdata',x,'Ydata',y,'visible','on')
      axis([0 1 0 1]);

% now attach the function to the axes
set(gca,'ButtonDownFcn', @mouseclick_callback)

% and we also have to attach the function to the children, in this
% case that is the line in the axes.
set(get(gca,'Children'),'ButtonDownFcn', @mouseclick_callback)
end
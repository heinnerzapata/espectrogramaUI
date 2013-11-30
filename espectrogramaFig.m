function varargout = espectrogramaFig(varargin)
% ESPECTROGRAMAFIG MATLAB code for espectrogramaFig.fig
%      ESPECTROGRAMAFIG, by itself, creates a new ESPECTROGRAMAFIG or raises the existing
%      singleton*.
%
%      H = ESPECTROGRAMAFIG returns the handle to a new ESPECTROGRAMAFIG or the handle to
%      the existing singleton*.
%
%      ESPECTROGRAMAFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ESPECTROGRAMAFIG.M with the given input arguments.
%
%      ESPECTROGRAMAFIG('Property','Value',...) creates a new ESPECTROGRAMAFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before espectrogramaFig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to espectrogramaFig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help espectrogramaFig

% Last Modified by GUIDE v2.5 29-Nov-2013 22:01:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @espectrogramaFig_OpeningFcn, ...
                   'gui_OutputFcn',  @espectrogramaFig_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before espectrogramaFig is made visible.
function espectrogramaFig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to espectrogramaFig (see VARARGIN)

% Choose default command line output for espectrogramaFig
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes espectrogramaFig wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = espectrogramaFig_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%d = str2num(get(handles.edit1, 'string'));
%set(handles.text1,'string',num2str(d*3));

N = str2num(get(handles.edit1, 'string')); % Numero de ventanas

figure(1)
[y,fs]=wavread('power.wav');
t=linspace(0,length(y)/fs,length(y));
subplot(2,1,1);       % add first plot in 2 x 1 grid
plot(t,y);
title('Senial Original de audio');

Nfft = 1024;
f = linspace(0,fs,Nfft);
G=abs(fft(y,Nfft));
subplot(2,1,2);       % add first plot in 2 x 1 grid
plot(f(1:Nfft/2),G(1:Nfft/2));
title('FFT senial original');


for c = 0:N-1
    
    figure(c+2)
    
    t2=linspace(((length(y)/fs)/N)*(c),((length(y)/fs)/N)*(c + 1),length(y)/N);
    subplot(2,1,1);       
    plot(t2,y(c*(length(y)/N) + 1: (c + 1) *(length(y)/N) ));      
    titleDesc = strcat(strcat(strcat('Ventana ',num2str(c+1)),' de '),num2str(N));
    title(titleDesc);
           
    f2 = linspace(0,fs,Nfft);
    G2=abs(fft(y(c*(length(y)/N) + 1: (c + 1) *(length(y)/N) ),Nfft));
    subplot(2,1,2);       % add first plot in 2 x 1 grid
    plot(f2(1:Nfft/2),G2(1:Nfft/2));
    title(strcat('FFT Ventana - ',num2str(c+1)));      

end





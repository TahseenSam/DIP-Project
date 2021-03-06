function varargout = DIPProject(varargin)
% DIPPROJECT MATLAB code for DIPProject.fig
%      DIPPROJECT, by itself, creates a new DIPPROJECT or raises the existing
%      singleton*.
%
%      H = DIPPROJECT returns the handle to a new DIPPROJECT or the handle to
%      the existing singleton*.
%
%      DIPPROJECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DIPPROJECT.M with the given input arguments.
%
%      DIPPROJECT('Property','Value',...) creates a new DIPPROJECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DIPProject_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DIPProject_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DIPProject

% Last Modified by GUIDE v2.5 23-Apr-2022 22:50:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DIPProject_OpeningFcn, ...
                   'gui_OutputFcn',  @DIPProject_OutputFcn, ...
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


% --- Executes just before DIPProject is made visible.
function DIPProject_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DIPProject (see VARARGIN)

% Choose default command line output for DIPProject
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% UIWAIT makes DIPProject wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DIPProject_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
%lets make background image
axes(handles.axes3)
imshow('texture.jpg')

% --- Executes on button press in uploadbutton1.
function uploadbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to uploadbutton1 (see GCBO)
%origImg=uigetfile('*.*');
% copyImg=origImg;
% setappdata(0,'copyImg',copyImg);
% setappdata(0,'origImg',origImg);
% origImg=imread(origImg);
% axes(handles.axes1);
% imshow(origImg);
% plot(handles.axes1,'OrigImg')
[filename, pathname] = uigetfile('*.*', 'Select From All Files');
if isequal(filename,0) || isequal(pathname,0)
        disp('User pressed cancel')
else
    filename=strcat(pathname,filename);
    origImg=imread(filename);
    axes(handles.axes1);
    imshow(origImg);
    copyImg=origImg;
    setappdata(0,'copyImg',copyImg);
    setappdata(0,'origImg',origImg);
    setappdata(0,'noisyImg',origImg)
%     axes(handles.axes2);
%     imshow(copyImg);
%     disp(['User selected ', fullfile(pathname, filename)])
end

% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in graybutton2.
function graybutton2_Callback(hObject, eventdata, handles)
% hObject    handle to graybutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
grayImg=getappdata(0,'origImg');
grayImg=rgb2gray(grayImg);
setappdata(0,'copyImg',grayImg)
axes(handles.axes2);
imshow(grayImg)
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in BWbutton3.
function BWbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to BWbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
bwImg=getappdata(0,'origImg');
bwImg=im2bw(bwImg);
setappdata(0,'copyImg',bwImg)
axes(handles.axes2);
imshow(bwImg)
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in resetbutton4.
function resetbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to resetbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB

origImg=getappdata(0,'origImg');
axes(handles.axes2)
imshow(origImg)
setappdata(0,'noisyImg',origImg)
setappdata(0,'rotatedImg',origImg)
setappdata(0,'copyImg',origImg)
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Exitbutton5.
function Exitbutton5_Callback(hObject, eventdata, handles)
msgbox('Thanks For Using This Image Processing Tool!');
pause(1);
close();
close();
% hObject    handle to Exitbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in SPNoiseBtn12.
function SPNoiseBtn12_Callback(hObject, eventdata, handles)%Salt & Pepper Noise
img=getappdata(0,'origImg');
img=imnoise(img,'salt & pepper',0.2);
setappdata(0,'noisyImg',img)
setappdata(0,'copyImg',img)
axes(handles.axes2);
imshow(img)
% hObject    handle to SPNoiseBtn12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Medianbutton13.
function Medianbutton13_Callback(hObject, eventdata, handles)
img=getappdata(0,'noisyImg');
% img=rgb2gray(img);
% img=medfilt2(img,[5,5]);
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);
img(:,:,1) = medfilt2(R);%default 3-by-3 neighborhood
img(:,:,2) = medfilt2(G);
img(:,:,3) = medfilt2(B);
axes(handles.axes2)
imshow(img);
setappdata(0,'copyImg',img)
% hObject    handle to Medianbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in cannyEdgebutton14.
function cannyEdgebutton14_Callback(hObject, eventdata, handles)
img=getappdata(0,'origImg');
img=rgb2gray(img);
img=edge(img,'canny');
axes(handles.axes2);
imshow(img)
setappdata(0,'copyImg',img)
% hObject    handle to cannyEdgebutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Sobelbutton16.
function Sobelbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to Sobelbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=getappdata(0,'origImg');
img=rgb2gray(img);
img=edge(img,'sobel');
axes(handles.axes2);
imshow(img)
setappdata(0,'copyImg',img)


% --- Executes on button press in Negativebutton17.
function Negativebutton17_Callback(hObject, eventdata, handles)
img=getappdata(0,'origImg');
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);
[m,n]=size(R);
for i=1:1:m
    for j=1:1:n
        R(i,j)=255-R(i,j);
        G(i,j)=255-G(i,j);
        B(i,j)=255-B(i,j);
    end
end
img(:,:,1) = R;%default 3-by-3 neighborhood
img(:,:,2) = G;
img(:,:,3) = B;
axes(handles.axes2)
imshow(img);
setappdata(0,'copyImg',img)
% hObject    handle to Negativebutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in rotatebutton18.
function rotatebutton18_Callback(hObject, eventdata, handles)
img=getappdata(0,'copyImg');
img=imrotate(img,90);
setappdata(0,'roatatedImg',img)
setappdata(0,'copyImg',img)
axes(handles.axes2);
imshow(img)
% hObject    handle to rotatebutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Histogrambutton19.
function Histogrambutton19_Callback(hObject, eventdata, handles)
img=getappdata(0,'origImg')
img=rgb2gray(img);
axes(handles.axes2);
imhist(img)
% hObject    handle to Histogrambutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in HistEqualBtn.
function HistEqualBtn_Callback(hObject, eventdata, handles)
img=getappdata(0,'origImg')
img=rgb2gray(img);
img=histeq(img);
axes(handles.axes2);
imhist(img)
% hObject    handle to HistEqualBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in poissonNoiseBtn21.
function poissonNoiseBtn21_Callback(hObject, eventdata, handles)
img=getappdata(0,'origImg');
img=imnoise(img,'poisson');
setappdata(0,'noisyImg',img)
setappdata(0,'copyImg',img)
axes(handles.axes2);
imshow(img)
% hObject    handle to poissonNoiseBtn21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in gaussianFilter.
function gaussianFilter_Callback(hObject, eventdata, handles)
img=getappdata(0,'noisyImg');
filter=fspecial('gaussian');
img=imfilter(img,filter);
setappdata(0,'copyImg',img)
axes(handles.axes2);
imshow(img)

% hObject    handle to gaussianFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in gaussianNoiseBtn.
function gaussianNoiseBtn_Callback(hObject, eventdata, handles)
img=getappdata(0,'origImg');
img=imnoise(img,'gaussian',0.3);
setappdata(0,'noisyImg',img)
setappdata(0,'copyImg',img)
axes(handles.axes2);
imshow(img)
% hObject    handle to gaussianNoiseBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in meanFilt24.
function meanFilt24_Callback(hObject, eventdata, handles)
img=getappdata(0,'noisyImg');
filter=fspecial('average');
img=imfilter(img,filter);
setappdata(0,'copyImg',img)
axes(handles.axes2);
imshow(img)

% hObject    handle to meanFilt24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

local CameraConst = {}

local CameraType=
{
    MainFreeViewCamera="MainFreeViewCamera",
    MainLayoutViewCamera="MainLayoutViewCamera",
    PerspectiveViewCamera="PerspectiveViewCamera",
    MainLayoutViewUpperCamera="MainLayoutViewUpperCamera",
    MainFollowViewCamera="MainFollowViewCamera",
    TransitionCamera="TransitionCamera",
    ShowGirlCamera="ShowGirlCamera",
    SyncPositionCamera="SyncPositionCamera",
}


local BlendStyle=
{
    Cut=-0,
    EaseInOut=1,
    EaseIn=2,
    EaseOut=3,
    HardIn=4,
    HardOut=5,
    Linear=6,
}

CameraConst.BlendStyle = BlendStyle
CameraConst.CameraType =  CameraType
return CameraConst

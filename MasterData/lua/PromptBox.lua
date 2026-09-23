--带确认的提示框
local canvasGroup=nil;
local isOpening=false;


---是否移动平台
local IsMobileplatform=false;
--inpt
local Input=CS.UnityEngine.Input
local KeyCode=CS.UnityEngine.KeyCode

function Awake()
    CSAPI.Getplatform();
    IsMobileplatform=CSAPI.IsMobileplatform;
    canvasGroup=ComUtil.GetCom(gameObject,"CanvasGroup");
end

function OnOpen()
    if close_tween then--打开界面时正在播放关闭动画
        CSAPI.RemoveGO(close_tween.gameObject,0);
        canvasGroup.alpha=1;
        close_tween=nil;
    end
    if(data ~= nil)then
        CSAPI.SetText(txtTitle, data.title or LanguageMgr:GetByID(1045))
        CSAPI.SetText(content,data.content or "");
        CSAPI.SetText(text_ok,data.okText or LanguageMgr:GetByID(1001));
        CSAPI.SetGOActive(btn_close,data.hasClose==true);
    end
    CSAPI.PlayUISound("ui_popup_open");
    ShowAction(nil);  
end

function OnClickOK()
    if(data ~= nil and data.okCallBack ~= nil)then
        data.okCallBack();
    end
    Close();
end

function Close()
    HideAction(function()
        data = nil;
        if not IsNil(view) and view.Close then
            view:Close();
            view = nil;
        end
    end);
end

--入场动画
function ShowAction(callBack)
    -- open_tween=CSAPI.ApplyAction(gameObject,"View_Open_Fade",callBack);
    if isOpening then
        do return end
    end
    if open_tween then
        open_tween:Play(function()
            isOpening=false;
            if callBack~=nil then
                callBack();
            end
        end);
    else
        isOpening=true;
        open_tween=CSAPI.ApplyAction(gameObject,"View_Open_Fade",function()
            isOpening=false;
            if callBack~=nil then
                callBack();
            end
        end);
    end
end

--退场动画
function HideAction(callBack)
    -- close_tween=CSAPI.ApplyAction(gameObject,"View_Close_Fade",callBack);
    if close_tween then
        close_tween:Play(callBack);
    else
        close_tween=CSAPI.ApplyAction(gameObject,"View_Close_Fade",callBack);
    end
end
function OnDestroy()    
    ReleaseCSComRefs();
end

function OnClickClose()
    Close();
end

function Update()
    CheckVirtualkeys()
end
---判断检测是否按了返回键
function CheckVirtualkeys()
    --仅仅安卓或者苹果平台生效
    if IsMobileplatform then
        if(Input.GetKeyDown(KeyCode.Escape))then
            if CSAPI.IsBeginnerGuidance()==false then
                OnClickOK();
            end

        end
    end
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
content=nil;
titleObj=nil;
txtSec=nil;
text_ok=nil;
view=nil;
end
----#End#----
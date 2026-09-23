--提示锁定助战界面
local canvasGroup = nil;
local isOpening=false;
---是否移动平台
local IsMobileplatform=false;
--inpt
local Input=CS.UnityEngine.Input
local KeyCode=CS.UnityEngine.KeyCode
local grid=nil;

function Awake()
	CSAPI.Getplatform();
	IsMobileplatform=CSAPI.IsMobileplatform;
	canvasGroup = ComUtil.GetCom(gameObject, "CanvasGroup");
end

function OnOpen()
	CSAPI.PlayUISound("ui_popup_open");
	if close_tween then --打开界面时正在播放关闭动画
		CSAPI.RemoveGO(close_tween.gameObject, 0);
		close_tween = nil;
		canvasGroup.alpha = 1;
	end
	if(data ~= nil) then
		CSAPI.SetText(txtTitle, data.title or LanguageMgr:GetByID(1045))

        if data.assist then
            if grid==nil then
                ResUtil:CreateUIGOAsync("RoleLittleCard/AssistCardGridTower",gridNode,function(go)
                    local grid=ComUtil.GetLuaTable(go);
                    grid.Refresh(data.assist:GetCard());
                end)
            else
                grid.Refresh(data.assist:GetCard());
            end
        end

		CSAPI.SetText(text_ok, data.okText or LanguageMgr:GetByID(1001));
		CSAPI.SetText(text_cancel, data.cancelText or LanguageMgr:GetByID(1002));

		LanguageMgr:SetEnText(text_ok1,1001)
		LanguageMgr:SetEnText(text_cancel1,1002)
	end
	ShowAction();
end

function OnClickOK()
	local callBack = data and data.okCallBack;
	data.okCallBack = nil;
	Close(callBack);
end

function OnClickCancel()
	local callBack = data and data.cancelCallBack;

	if data and data.cancelCallBack then
		data.cancelCallBack = nil;
	end

	Close();

    if(callBack) then		
		callBack();				
	end
end


function OnClickClose()	
	if(data.isClickMask)then
		Close();
	end
end

function Close(callBack)	
	HideAction(function()
		if callBack then
			callBack()
		end
		
		data = nil;
		if(view and view.Close) then
			view:Close();
            view = nil;
		end
	end);
end

--入场动画
function ShowAction(callBack)
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
	if close_tween then
		close_tween:Play(callBack);
	else
		close_tween = CSAPI.ApplyAction(gameObject, "View_Close_Fade", callBack);
	end
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
				OnClickCancel();
			end

		end
	end
end



--带确认取消的提示框
local canvasGroup = nil;
local isOpening=false;
local isHideDailyTips = false
---是否移动平台
local IsMobileplatform=false;
--inpt
local Input=CS.UnityEngine.Input
local KeyCode=CS.UnityEngine.KeyCode


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
		CSAPI.SetText(content, data.content or "");
        if(StringUtil:IsEmpty(data.content))then
            LogError(string.format("tips error.%s",table.tostring(data,true)));
        end
		--CSAPI.SetText(text_title,data.title or StringConstant.hint);
		CSAPI.SetText(text_ok, data.okText or LanguageMgr:GetByID(1001));
		CSAPI.SetText(text_cancel, data.cancelText or LanguageMgr:GetByID(1002));

		if data.okText2 then
			CSAPI.SetText(text_ok1, data.okText2);
		else
			LanguageMgr:SetEnText(text_ok1,1001)
		end
		
		if data.cancelText2 then
			CSAPI.SetText(text_cancel1, data.cancelText2);
		else
			LanguageMgr:SetEnText(text_cancel1,1002)
		end

		if data.dailyKey then
			isHideDailyTips = not TipsMgr:IsShowDailyTips(data.dailyKey)
			SetDailyTips()
		end
	end
	ShowAction();
end

function SetDailyTips()
	CSAPI.SetGOActive(hideImg1, not isHideDailyTips)
	CSAPI.SetGOActive(hideImg2, isHideDailyTips)
end

function OnClickHide()
	isHideDailyTips = not isHideDailyTips
	SetDailyTips()
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
		if data.dailyKey then
			TipsMgr:SaveDailyTips(data.dailyKey, isHideDailyTips)
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



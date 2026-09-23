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
    CSAPI.SetText(txtTitle, LanguageMgr:GetByID(1045))
    CSAPI.SetText(content, LanguageMgr:GetTips(14039));
    CSAPI.SetText(text_ok, data.okText or LanguageMgr:GetByID(26058));
    CSAPI.SetText(text_cancel, LanguageMgr:GetByID(1002));
    CSAPI.SetText(text_battle, LanguageMgr:GetByID(26059));
    -- if openSetting==nil then
        isHideDailyTips = not TipsMgr:IsShowDailyTips(FormationUtil.RaisingDailyKey)
        SetDailyTips()
    -- end
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
    if data and data[1] then
        EventMgr.Dispatch(EventType.Team_Raising_GoTeamView,data[1].lessMemberID);
    end
    Close();
end

function OnClickBattle()
    if data and #data>1 and data[2] then
        EventMgr.Dispatch(EventType.Team_Raising_GoBattle,{data[2].id,true});
    end
    Close();
end

function OnClickCancel()
	Close();
end

function OnClickClose()	
    Close();
end

function Close(callBack)	
	HideAction(function()
		if callBack then
			callBack()
		end
        TipsMgr:SaveDailyTips(FormationUtil.RaisingDailyKey, isHideDailyTips)
		
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



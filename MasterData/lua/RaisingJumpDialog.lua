--带确认取消的提示框
local canvasGroup = nil;
local isOpening=false;
local isHideDailyTips = false
---是否移动平台
local IsMobileplatform=false;
--inpt
local Input=CS.UnityEngine.Input
local KeyCode=CS.UnityEngine.KeyCode
local currCostInfo=nil;
local currCostHot=0;
local targetIcons={
    [FormationUtil.RaisingType.Gift]="img_14_3",
    [FormationUtil.RaisingType.Skill]="img_14_2",
    [FormationUtil.RaisingType.ChipQuality]="img_14_5",
    [FormationUtil.RaisingType.ChipLevel]="img_14_4",
    [FormationUtil.RaisingType.CardLevel]="img_14_1",
}
local targetTips={
    [FormationUtil.RaisingType.Gift]=20010,
    [FormationUtil.RaisingType.Skill]=20009,
    [FormationUtil.RaisingType.ChipQuality]=20026,
    [FormationUtil.RaisingType.ChipLevel]=20011,
    [FormationUtil.RaisingType.CardLevel]=20008,
}
function Awake()
	CSAPI.Getplatform();
	IsMobileplatform=CSAPI.IsMobileplatform;
	canvasGroup = ComUtil.GetCom(gameObject, "CanvasGroup");
end

function OnOpen()
	CSAPI.PlayUISound("ui_popup_open");
    isHideDailyTips = not TipsMgr:IsShowDailyTips(FormationUtil.RaisingDailyKey2)
    SetDailyTips()
    CSAPI.SetText(text_cancel,LanguageMgr:GetByID(15142));
    CSAPI.SetText(text_battle, LanguageMgr:GetByID(26059));
    if data and #data>1 then
        --初始化行动值消耗
        -- --如果配置表中存在cost值，则读取cost信息，否则直接当热值处理
        -- currCostInfo=DungeonUtil.GetCost(data[2]);
        -- currCostHot=DungeonUtil.GetHot(data[2]);
        CSAPI.SetText(content,LanguageMgr:GetByID(FormationUtil.RaisingTypeTips2[data[1].raisingType]))
        --显示图标和描述
        ResUtil.FightOver:Load(targetIcon,targetIcons[data[1].raisingType]);
        CSAPI.SetText(txtTips,LanguageMgr:GetByID(targetTips[data[1].raisingType]))
    end
    -- SetEnterCost();
end

function SetDailyTips()
	CSAPI.SetGOActive(hideImg1, not isHideDailyTips)
	CSAPI.SetGOActive(hideImg2, isHideDailyTips)
end

function OnClickHide()
	isHideDailyTips = not isHideDailyTips
	SetDailyTips()
end

function OnClickBattle()
    if data and #data>1 and data[2] then
        EventMgr.Dispatch(EventType.Team_Raising_GoBattle,{data[2].id,false});
    end
    Close();
end

function OnClickCancel()
    -- Close();
    -- 根据类型进行跳转
    if data and data[1] then
        local cardData = RoleMgr:GetData(data[1].targetCardID);
        if cardData == nil then
            LogError("未找到对应卡牌数据：" .. tostring(data[1].targetCardID))
            do
                return
            end
        end
        -- data[1].raisingType = 2
        CSAPI.OpenView("RoleInfo", cardData);
        if data[1].raisingType == FormationUtil.RaisingType.Gift then
            CSAPI.OpenView("RoleCenter", {cardData}, "talent");
        elseif data[1].raisingType == FormationUtil.RaisingType.Skill then
            local newSkillDatas = cardData:GetSkillsForShow()
            CSAPI.OpenView("RoleCenter", {cardData, newSkillDatas[1].id}, "skill");
        elseif data[1].raisingType == FormationUtil.RaisingType.ChipQuality or data[1].raisingType == FormationUtil.RaisingType.ChipLevel then
            CSAPI.OpenView("RoleEquip", {
                card = cardData
            });
        elseif data[1].raisingType == FormationUtil.RaisingType.CardLevel then
            CSAPI.OpenView("RoleUpBreak", cardData);
        end
    end
end

function OnClickClose()	
    Close();
end

function Close(callBack)	
    if data and data[2] then
        local key=data[2] and "RaisingTips"..data[2].id or nil;
        TipsMgr:SaveDailyTips(key,true) --记录当前时间
    end
    if callBack then
        callBack()
    end
    if FormationUtil.RaisingDailyKey2 then
        TipsMgr:SaveDailyTips(FormationUtil.RaisingDailyKey2, isHideDailyTips)
    end
    
    data = nil;
    if(view and view.Close) then
        view:Close();
        view = nil;
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



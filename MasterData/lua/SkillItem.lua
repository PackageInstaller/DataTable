--技能item
--技能配置
cfg = nil;
--点击回调
clickCallBack = nil;
data = nil;

local iconColors = {"white", "green", "blue", "purple", "yellow", "red"};

function Awake()
	if(goCostText) then
		txtCostContent = ComUtil.GetComInChildren(goCostText, "Text");
	end
	txtCostContent1 = ComUtil.GetComInChildren(goCostText1, "Text");
	txtCd = ComUtil.GetComInChildren(cd, "Text");
	--imgMask = ComUtil.GetComInChildren(mask, "Image");	
	--CSAPI.SetGOActive(iconTitle,false);              
end

--指挥官技能
function InitForPlayerSkill()
	CSAPI.SetGOActive(iconbg, false);
	CSAPI.SetGOActive(iconRange, false);
	CSAPI.SetGOActive(cost, false);
	CSAPI.SetScale(mask, 0, 0, 0);
end

--是否普通攻击
function IsBaseAttack()
	return cfg and cfg.type == 1;
end

function GetCostNP()
	if(costData and costData.attr == "np") then
		return costData.val or 0;
	end
	return cfg and cfg.np or 0;
end

function HideCost()
	if(txtCostContent) then
		txtCostContent.text = "";
	end
	txtCostContent1.text = "";
end

function GetCfgSkillDesc(cfgSkill)
    if(cfgSkill)then
        return  Cfgs.CfgSkillDesc:GetByID(cfgSkill.id);
    end
end

--初始化
function InitItem(cfgSkill, skillData, skillCostData, character)
--    if(cfgSkill)then
--        LogError(cfgSkill.name .. cfgSkill.id .. ":" .. (skillData and skillData.usable or "nil"))
--        --LogError(skillData);
--    end
	cfg = cfgSkill;	
	data = skillData;
	costData = skillCostData;
	local cfgSkillDesc = GetCfgSkillDesc(cfg);
	CSAPI.SetGOActive(gameObject, cfgSkill and true or false)
	
	--    LogError("初始化技能数据==========================================");
	--    LogError(cfg);
	--    LogError(cfgSkill);
	--    LogError(data);
	if(cfgSkill) then
		local resIcon = cfgSkillDesc and cfgSkillDesc.icon;
        local resIcon1 = nil;
        local resIcon2 = nil;
		--local resIconTitle;
		local costValue = 0;
		local costText = "";
		
		if(costData) then
			costValue = costData.val or 0;			
			costText = costData.attr == "np" and LanguageMgr:GetByID(28014) or  LanguageMgr:GetByID(28012);
			
		else
			if(cfg.sp and cfg.sp > 0) then
				costValue = cfg.sp;
				costText =  LanguageMgr:GetByID(28012);
			else
				costValue = cfg.np or 0;
				costText = LanguageMgr:GetByID(28014);
				
			end
		end			
		
		if(btnEff)then
			local state = Usable() > 0;
			CSAPI.SetGOActive(btnEff,state);	
		end
		
		local skillName = nil;
		--检测是否召唤和合体技能
		if(cfg.type == SkillType.Summon) then
			resIcon1 = "w_summon1";
            resIcon2 = "w_summon2";			
			--skillName = StringConstant.fight_skill_name1;
			--resIconTitle = "w_machine_loading";         
		elseif(cfg.type == SkillType.Unite) then
			resIcon1 = "w_combo1";
            resIcon2 = "w_combo2";
			--skillName = StringConstant.fight_skill_name2;
			--resIconTitle = "w_core";   
		elseif(cfg.type == SkillType.Transform) then
			resIcon1 = "w_transform1";
            resIcon2 = "w_transform2";
			--skillName = StringConstant.fight_skill_name3;
		end
		
		if(nameText) then
			CSAPI.SetText(nameText, skillName);
		end
		if(resIcon) then
			ResUtil.IconSkill:Load(icon, resIcon);
		end
        if(resIcon1)then
            ResUtil.IconSkill:Load(icon1, resIcon1);
        end
		if(resIcon2)then
            ResUtil.IconSkill:Load(icon2, resIcon2);
        end
		--        CSAPI.SetGOActive(iconTitle,resIconTitle ~= nil);
		--        if(resIconTitle)then
		--            ResUtil.IconSkill:Load(iconTitle,resIconTitle);            
		--        end
		--CSAPI.SetGOActive(cost,costValue > 0);
		--txtCost.text = costValue .. "";    
		if(txtCostContent) then
			txtCostContent.text = costText;
		end
		txtCostContent1.text = costValue <= 0 and "--" or(costValue .. "");		
		--CSAPI.SetGOActive(goNoCost, costValue <= 0);
		local cdValue = data and data.cd or 0;
		CSAPI.SetGOActive(mask, cdValue > 0);
		if(cdValue > 0) then
			if(cfg.cd) then
				txtCd.text = cdValue .. "";
				--imgMask.fillAmount = cd / cfg.cd;
			else
				LogError("后端给了CD，前端配置无CD，可能前端段配置不一致引起的！！！");
			end
		end
		
		SetClickState(Usable() > 0);
		CSAPI.SetGOActive(passive, IsPassive());
		SetSelect(true,true);
		if(costValue == 0) then
			local x, y, z = CSAPI.GetPos(icon);
			EventMgr.Dispatch(EventType.Guide_Hint, {x = x, y = y, z = z});
		end
	end		
	
	LoadIconBg(cfgSkill);
	
	local resRange = "effective_range_07";
	
	if(cfg and cfg.range_key) then
		local cfgRange = Cfgs.skill_range:GetByKey(cfg.range_key);
		resRange = cfgRange.skill_icon;
	end
	local cfgSkillDesc = GetCfgSkillDesc(cfg);
	if(cfgSkillDesc and cfgSkillDesc.icon_bg_type) then
		local colorIndex = cfgSkillDesc.icon_bg_type or 1;
		local colorStr = "";
		if(colorIndex and iconColors[colorIndex]) then
			colorStr = "_" .. iconColors[colorIndex];
		end
		resRange = "UIs/Skill/" .. resRange .. colorStr .. ".png";
		CSAPI.LoadImg(iconRange, resRange, true, nil, true);
		
		if(iconbg1) then
			CSAPI.LoadImg(iconbg1, "UIs/Skill/iconbg" .. colorStr .. ".png", true, nil, true);
		end
	end

	CSAPI.SetGOActive(prohibit, Usable() < 0);
	
	SetSelect(false);
	SetDescState(false);
	
	if(txtLock) then
		CSAPI.SetText(txtLock, "")
	end
	ActiveOrHide();

    local isSpeSkill = cfg and SkillUtil:IsSpecialSkill(cfg.type);
    local speSkillNoActive = isSpeSkill and Usable() <= 0;
	if(isSpeSkill) then
		CSAPI.SetGOActive(disableState, speSkillNoActive);
		CSAPI.SetGOActive(btnNode, not speSkillNoActive);
	end

	--蓄力显示
	if(cfg and cfg.fury and character)then
		local fury,furyMax,furyP = character.GetFury();		
		fury = fury or 0;
		furyMax = furyMax or 1;
		furyP = furyP or 0;
		--LogError(string.format("fury:%s",fury));
		CSAPI.SetGOActive(furyNode,fury > 0);
		if(fury > 0)then		
			if(not furyBar)then
				furyBar = ComUtil.GetCom(furyBarGo,"BarBase");  
			end
			if(furyBar)then
				furyBar:SetProgress(furyP);
			end 
			CSAPI.SetText(furyVal,tostring(fury));	
			CSAPI.SetGOActive(furingEffect,furyP < 1);
			CSAPI.SetGOActive(furyEffect,furyP >= 1);
		end
	else
		CSAPI.SetGOActive(furyNode,false);
	end
end

function GetColorIndex()
    local cfgSkillDesc = GetCfgSkillDesc(cfg);
    local colorIndex = cfgSkillDesc and cfgSkillDesc.icon_bg_type or 1;
    return colorIndex;
end

function SetEffState(state)
    CSAPI.SetGOActive(effNode,state);
end
function SetEffColor(index)
    local targetColor = index and iconColors[index]
    local targetEffName = targetColor and ("eff_" .. targetColor) or "";

    for _,color in ipairs(iconColors)do
        local effName = "eff_" .. color;
        CSAPI.SetGOActive(this[effName],effName == targetEffName);
    end
end


--可外部重写
function ActiveOrHide()
	--未通关巅峰战，pve不开放机神传送
	if(cfg and cfg.type == SkillType.Summon) then
		--if(g_FightMgr and (g_FightMgr.type == SceneType.PVE or g_FightMgr.type == SceneType.SinglePVE))then
		if(not PlayerClient:IsPassNewPlayerFight()) then
			if(not PlayerClient:OpenSummon()) then			
				CSAPI.SetGOActive(gameObject, false);
			end
		end
		--end
	end
end

function LoadIconBg(cfg)
    local cfgSkillDesc = GetCfgSkillDesc(cfg);
	if(not cfgSkillDesc) then
		return;
	end	
	local index = cfgSkillDesc.icon_bg_type or 1;		
	local res = "UIs/Skill/" .. iconColors[index] .. ".png";
	--CSAPI.LoadImg(iconbg, res, true, nil, true);
	CSAPI.LoadImg(costbg, "UIs/Skill/costbg_" .. iconColors[index] .. ".png", true, nil, true);
	if(goSelect) then
		local resSel = "UIs/Skill/sel_" .. iconColors[index] .. ".png";
		CSAPI.LoadImg(goSelect, resSel, true, nil, true);
	end
    SetEffColor(index);
end

function SetClickState(state)
	clickState = state;
--	CSAPI.SetImgValidState(icon, state);
--	if(iconbg) then
--		CSAPI.SetImgValidState(iconbg, state);	
--	end
    if(node)then
	    CSAPI.SetImgValidState(node, state,true);
    end
end
function GetClickState()
	return clickState;
end


function ShowUnusableTips()
    local index = Usable();
    EventMgr.Dispatch(EventType.Fight_ShowTips_SkillUnusable,index);
end

function Usable()
    --LogError(data and data.usable);
	return data and data.usable or 1;
end
--是否复活技能
function IsRelive()
	return cfg and (cfg.type == SkillType.Revive or cfg.revive_teammate);
end
--是否合体
function IsCombo()
	return cfg and cfg.type == SkillType.Unite;
end
--是否变身
function IsTransform()
	return cfg and cfg.type == SkillType.Transform;
end

--获取技能ID
function GetSkillId()
	return cfg and cfg.id;
end

function InitSetting(index)
	if(not index) then
		return;
	end
	
	local isNormal = index <= 3;
	
	--    local bgName = "skill_frame" .. (isNormal and 1 or 2);
	--    ResUtil.IconSkill:Load(iconbg,bgName);
	--    local okIcon = isNormal and "w_attack" or "w_release";    
	--    ResUtil.IconSkill:Load(goSelect,okIcon);
end

function AddClickCallBack(callBack)
	clickCallBack = callBack;
end

function IsPassive()
    return cfg == nil or cfg.type == SkillType.Passive;
end

function OnClick()
	ShowUnusableTips();

	if(IsPassive()) then
        Tips.ShowTips(string.format(LanguageMgr:GetTips(19007),LanguageMgr:GetTips(19013)));
		return;
	end
	
	if(clickCallBack ~= nil) then
		clickCallBack(this);
	end
end
--按下
function OnPressDown()	
	if(not isPressEnable) then 
		return 
	end 
	currShowIndex = currShowIndex and(currShowIndex + 1) or 1;
	FuncUtil:Call(DelayShowDesc, nil, 1000, currShowIndex);
end
--延迟显示技能描述
function DelayShowDesc(targetShowIndex)
	if(not currShowIndex or currShowIndex ~= targetShowIndex) then
		return;
	end
	
	SetDescState(true);
end

--松开
function OnPressUp()
	if(not isPressEnable) then 
		return 
	end
	currShowIndex = currShowIndex and(currShowIndex + 1) or 1;
	SetDescState(false);
end


--展示技能描述
function SetDescState(b)	
	if(cfg and b) then
		local isTalent = false
		local id = GetSkillId()
		CSAPI.OpenView("RoleSkillDetail", {id,gameObject})
	else
		CSAPI.CloseView("RoleSkillDetail")
	end
end

-- --展示技能描述
-- function SetDescState(state)	
-- 	local isShow = false;
-- 	if(cfg and state) then
-- 		isShow = true;
-- 	end
-- 	if(isShow) then
-- 		--typeIndex 1234 :技能，特殊技能，主天赋，副天赋 (天赋不走技能表，所以要传入参数区分)
-- 		local _id = GetSkillId()
-- 		local _cfg = _id and Cfgs.skill:GetByID(_id) or nil 
-- 		if(_cfg) then 
-- 			local _typeIndex = 1
-- 			if(_cfg and _cfg.main_type == SkillMainType.CardSpecial) then
-- 				_typeIndex = 2
-- 			end
-- 			CSAPI.OpenView("RoleSkillInfoView", {posGo = posItem,  id = _id, typeIndex = _typeIndex})  --已改成长按
-- 		end
-- 	end
-- end
function SetPosItm(_posItem)
	posItem = _posItem
end

--设置选中状态
function SetSelect(isSelect,force)
    if(not force and IsPassive())then
        return;
    end

	CSAPI.SetGOActive(goSelect, isSelect);

    SetEffState(isSelect);

    if(isSelect)then
        
        local colorIndex = GetColorIndex();
        local color = colorIndex and iconColors[colorIndex] or "";
        local uvEffGO = this["uv_" .. color];
        if(uvEffGO)then
            local selOverload = FightClient:IsSelOverload();
            local isPassive = IsPassive();
            
            CSAPI.SetGOActive(uvEffGO,selOverload or isPassive);
        end
    end
end 

function PressEnable()
	isPressEnable = true 
end

--function OnDestroy()
--    UIUtil:RemoveRef(this);

--	txtCostContent = nil;
--	txtCostContent1 = nil;
--	txtCd = nil;  

--    gameObject=nil;
--    transform=nil;

--    btn=nil;
--    iconbg=nil;
--    txtLock=nil;
--    iconbg1=nil;
--    icon=nil;
--    passive=nil;
--    iconRange=nil;
--    goSelect=nil;
--    cost=nil;
--    costbg=nil;
--    goCostText=nil;
--    goCostText1=nil;
--    goCostText2=nil;
--    goNoCost=nil;
--    prohibit=nil;
--    mask=nil;
--    cd=nil;
--    view=nil;

--    this=nil; 
--end
----#End#----
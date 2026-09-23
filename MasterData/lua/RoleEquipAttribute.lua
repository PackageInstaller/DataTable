--角色装备属性面板
local layout=nil;
local statusItems;
local statusDatas;
local data=nil;
local skillArr;
local skillPoints;
local state=1;--state=1：属性和技能都是简略，=2:隐藏技能显示属性=3：隐藏属性显示技能
local items={}
local topY=195;
local bottomY=195;
local topOY=195;
local bottomOY=195;
local t_Top=nil;
local t_Bottom=nil;

function Awake()
    t_Top=ComUtil.GetCom(topLayout,"ActionUISize");
    t_Bottom=ComUtil.GetCom(bottomLayout,"ActionUISize");
end
function Refresh(card)
    data=card;
    if data==nil then
        LogError("未传入想查看的卡牌！")
        return;
    end
    InitAttrs();
    InitSkills();
    SetLayout();
end

function SetLayout()
    --根据值设置样式
    local tips1,tips2=23050,23050;
    local rotate1,rotate2=90,90;
    local color1,color2="ffffff","ffffff"
    local b_no1,b_no2=true,true
    local d1,d2=0,0
    if state==1 then
        topY=195;
        bottomY=195;
    elseif state==2 then
        tips1=23049;
        rotate1=-90;
        color1="ffc146"
        b_no2=false;
        topY=315;
        bottomY=46;
        d1=40;
    elseif state==3 then
        tips2=23049;
        rotate2=-90;
        color2="ffc146"
        b_no1=false;
        topY=46;
        bottomY=315;
        d2=40;
    end
    -- CSAPI.SetGOActive(tNode,b_no1);
    -- CSAPI.SetGOActive(bNode,b_no2);
    if t_Top and t_Bottom then
        CSAPI.SetGOActive(mask,true);
        t_Top.delay=d1;
        t_Top:SetOrgSizeSize(910,topOY);
        t_Top:SetTargetSize(910,topY);
        t_Top:Play();
        t_Bottom.delay=d2;
        t_Bottom:SetOrgSizeSize(910,bottomOY);
        t_Bottom:SetTargetSize(910,bottomY);
        t_Bottom:Play(function()
            topOY=topY;
            bottomOY=bottomY;
            CSAPI.SetGOActive(mask,false);
        end);
    end
    CSAPI.SetText(txt_tState,LanguageMgr:GetByID(tips1));
    CSAPI.SetText(txt_bState,LanguageMgr:GetByID(tips2));
    CSAPI.SetTextColorByCode(txt_tState,color1)
    CSAPI.SetTextColorByCode(txt_bState,color2)
    CSAPI.SetImgColorByCode(tArrow,color1);
    CSAPI.SetImgColorByCode(bArrow,color2);
    CSAPI.SetAngle(tArrow,0,0,rotate1);
    CSAPI.SetAngle(bArrow,0,0,rotate2);
end

function InitAttrs()
    statusItems = statusItems or {}	
	statusDatas = {}
    local baseData = data:GetBaseProperty()
	local curStatusData = data:GetTotalProperty()
    local maxNum=state==1 and 4 or #g_RoleAttributeList
	for i, v in ipairs(g_RoleAttributeList) do
		local cfg = Cfgs.CfgCardPropertyEnum:GetByID(v)
		local key = cfg.sFieldName
		local _data = {}
		_data.id = v
		local val1 = baseData[key]
		local val2 = curStatusData[key]
        local num="0";
        if(val1) then
            num=RoleTool.GetStatusValueStr(key, val1)
        end
		_data.val1 = num
		if(val2 > val1) then
			_data.val2 = "+" .. RoleTool.GetStatusValueStr(key, val2 - val1)
		else
			_data.val2 = nil
		end
		_data.nobg = true
		table.insert(statusDatas, _data)
        if #statusDatas>=maxNum then
            break;
        end
	end
    --简略显示4条，否则全部显示
	ItemUtil.AddItems("AttributeNew2/AttributeItem6", statusItems, statusDatas, attrRoot)
end

function InitSkills()
    local skills=data:GetEquipSkillPoint();
    if skills then --读取装备技能信息
        skillArr={};
        skillPoints={}; --用于记录技能点数
        for k,v in ipairs(skills.eskills) do
            local skillCfg = Cfgs.CfgEquipSkill:GetByID(v);
            table.insert(skillArr, skillCfg);
            skillPoints[skillCfg.group]=skillCfg.nLv;
        end
		-- if skills.fightSkills then --主动技能    
		-- 	for k, v in pairs(skills.fightSkills) do
        --         local skillCfg = Cfgs.CfgEquipSkill:GetByID(v);
        --         if skillCfg then
        --             skillPoints[skillCfg.group]=skillCfg.nLv;
        --         end
		-- 	end
		-- end
		-- if skills.propertySkills then  --被动技能
		-- 	for k, v in pairs(skills.propertySkills) do
		-- 		local skillCfg =  Cfgs.CfgEquipSkill:GetByID(v);
        --         if skillCfg then
        --             skillPoints[skillCfg.group]=skillCfg.nLv;
        --         end
		-- 	end
        -- end
        -- if skills.passivBufIds then  --buff技能
		-- 	for k, v in pairs(skills.passivBufIds) do
		-- 		local skillCfg =  Cfgs.CfgEquipSkill:GetByID(v);
        --         if skillCfg then
        --             skillPoints[skillCfg.group]=skillCfg.nLv;
        --         end
		-- 	end
        -- end
        -- for k,v in pairs(skillPoints) do
        --     local skillGroup=Cfgs.CfgEquipSkill:GetGroup(k);
        --     if skillGroup then
        --         for k,cfg in ipairs(skillGroup) do
        --             if v==cfg.nLv or (v>cfg.nLv and k==#skillGroup) then
        --                 table.insert(skillArr,cfg);
        --                 break;
        --             end
        --         end
        --     end
        -- end
        if skillArr then
            table.sort(skillArr,function(a,b)
                if a.nQuality~=b.nQuality then
                    return a.nQuality>b.nQuality
                elseif a.nLv~=b.nLv then
                    return a.nLv>b.nLv;
                else
                    return a.group>b.group;
                end
            end)
        end
    end
    curDatas=skillArr or {};
    local curListNum=#curDatas;
    if state~=2 and curListNum>0 then
        ItemUtil.AddItems("EquipInfo/EquipSkillAttribute2", items, curDatas, skillObj, OnClickSkillItem, 1);
    end
    CSAPI.SetGOActive(skillRoot,curListNum>0);
    CSAPI.SetGOActive(bTmpty,curListNum==0);
    CSAPI.SetText(txt_sNum,curListNum>0 and tostring(#curDatas) or "--");
end


function OnClickSkillItem(cfg)
    --打开技能描述面板
    CSAPI.OpenView("RoleEquipSkillInfo",cfg);
end

function OnClickSkillInfo()
    CSAPI.OpenView("RoleEquipSkillFull",{card=data,skillPoints=skillPoints});
end

function OnClickTop()
    if state==1 then 
        state=2;
    elseif state==2 then
        state=1;
    elseif state==3 then
        state=2;
    end
    Refresh(data)
end

function OnClickBottom()
    if state==1 then 
        state=3;
    elseif state==2 then
        state=3;
    elseif state==3 then
        state=1;
    end
    Refresh(data)
end

function Close()
    CSAPI.SetGOActive(gameObject,false)
end
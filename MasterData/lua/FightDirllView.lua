--训练面板
local itemPath = "UIs/FightDirll/FightDirllItem"
local enemyCfgs = nil
local cfgRole = nil
local cardData = nil
local curDatas = nil
local selIndex = 1

--传入数据cardData，获取当前item的数据来获取类型，根据类型和角色id来获取对应怪物组id，传入角色怪物组id和敌兵怪物组id
function Awake()
	layout = ComUtil.GetCom(vsv, "UIInfinite")
	layout:Init(itemPath, LayoutCallBack, true)
end

function LayoutCallBack(index)
	local lua = layout:GetItemLua(index)
	if(lua) then
		local _data = curDatas[index]
		lua.SetIndex(index)
		lua.SetClickCB(OnItemClickCB)
		lua.Refresh(_data, selIndex)
	end
end

function OnItemClickCB(item)
	selIndex = item.GetIndex()
	layout:UpdateList()
end

function OnOpen()
	cardData = data
	if cardData then
		InitPanel()
	end
end

function InitPanel()
	local dirllID = cardData:GetCfg().dirll
	if dirllID then
		cfgRole = Cfgs.CfgDirllRole:GetByID(dirllID)
	else
		LogError("找不到训练场ID!")
	end
	
	curDatas = {}
	enemyCfgs = Cfgs.CfgDirllEnemy:GetAll()
	if enemyCfgs and cfgRole and cfgRole.infos then
		for i, v in ipairs(cfgRole.infos) do
			for k, m in pairs(enemyCfgs) do
				if(v.groupType == m.groupType) then
					table.insert(curDatas, m)
				end
			end		
		end		
	end
	table.sort(curDatas, function(a, b)
		return a.id < b.id
	end)
	
	
	layout:IEShowList(#curDatas)
end

--获取我方训练阵容信息
function GetRoleInfo(type)
	if cfgRole then
		for i, v in ipairs(cfgRole.infos) do
			if v.groupType == type then
				return v
			end
		end
	end
	return nil
end

function OnClickEnter()
	local selData = curDatas[selIndex]
	if(selData) then
		local roleInfo = GetRoleInfo(selData.groupType)
		local role_monster_id = roleInfo.groupID
		local enemy_monster_id = selData.groupID
		if role_monster_id and enemy_monster_id then
			FightClient:SetDirll(cardData:GetID());
			PlayerPrefs.SetInt("key_for_dirll_fight_1", role_monster_id);
			PlayerPrefs.SetInt("key_for_dirll_fight_2", enemy_monster_id);
			CreateDirllFight(role_monster_id, enemy_monster_id, function(stage, winer)
				FightActionMgr:Push(FightActionMgr:Apply(FightActionType.FightEnd, {custom_result = 1, bIsWin = 1, content = LanguageMgr:GetByID(15054)}));
			end, cfgRole.roleID, cardData:GetSkinID(),RoleTool.GetElseSkin(cardData), GetSpecialSkills());

			RoleMgr:SetRoleListSortData() -- 保存卡牌列表界面的排序，以便战斗返回时按保存的打开
		else
			LogError("获取不到怪物组id！" .. role_monster_id .. "|" .. enemy_monster_id)
		end
	end
end

--获取特殊技能id
function GetSpecialSkills()
	local skills = {}
	if cardData:GetSpecialSkill() then
		for k, v in pairs(cardData:GetSpecialSkill()) do
			table.insert(skills,v.id)
		end
	end
	if #skills > 0 then
		table.sort(skills,function (a,b)
			return a<b
		end)
	end
	return skills
end

function OnClickClose()
	view:Close()
end 
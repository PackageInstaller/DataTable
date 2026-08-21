-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/view/role_experience/RoleExperienceView.lua

module("logic.extensions.welfare.view.role_experience.RoleExperienceView", package.seeall)

local M = class("RoleExperienceView", DynamicFragmentView)
local RoleExperienceType = ActivityEnum.LogicType.HERO_EARLY_ACCESS

function M:ctor()
	M.super.ctor(self)

	self._roleCellList = {}
	self._roleCellToActivityData = {}
	self._selectIndex = 1
	self._roleExperienceItemCell = nil
	self._characterCell = nil
end

function M:buildUI()
	self.text_txtCondition = self._registry:getUIComponent("activity_role_experience_panel_1569806031", UIComponentType.TextMeshProUGUI)
	self.text_residueTime = self._registry:getText("activity_role_experience_panel_2054290349")
	self.text_roleName = self._registry:getText("activity_role_experience_panel_647444901")
	self.img_imgCareerDi = self._registry:getImage("activity_role_experience_panel_1509569391")
	self.img_imgCareerSign = self._registry:getImage("activity_role_experience_panel_1417464087")
	self.img_imgRole = self._registry:getImage("activity_role_experience_panel_-937885699")
	self._imgRole = Astral.ImageDynIcon.Get(self.img_imgRole.gameObject)
	self._textTitle = self._registry:getText("activity_role_experience_panel_1386164757")
	self.btn_btnStartBattle = self._registry:getBtn("2&btn_right_1251431307")
	self.btn_btnSearch = self._registry:getBtn("3&btn_left_-1571983320")
	self.btn_rolePreview = self._registry:getBtn("activity_role_experience_panel_1772202618")
	self.tr_rolesParent = self._registry:getRectTransform("activity_role_experience_panel_-797419836")
	self.roleItem = self._registry:getGo("1&hero_item_1481649446")
	self.go_backpack_item = self._registry:getGo("1&rewards_detail_item_2141037416")
	self.img_quality = self._registry:getImage("activity_role_experience_panel_856223933")
	self._roleExperienceItemCell = Astral.LuaComponentContainer.Add(self.go_backpack_item, RoleExperienceItemCell)

	self:_initRoleExperienceList()
end

function M:onEnter()
	self:_setEvent(true)
	GlobalDispatcher:addEventListener(EventType.ROLE_EXPERIENCE_RECEIVE_REWARD, self._onReceiveReward, self)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_Com)
	self:onClickHeroItem(self._roleCellList[self._selectIndex])
	WelfareUtil.playWelfareViewAnim(self.mainGO, "open")
end

function M:onExit()
	self:_setEvent(false)
	GlobalDispatcher:removeEventListener(EventType.ROLE_EXPERIENCE_RECEIVE_REWARD, self._onReceiveReward, self)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_Com)
	removetimer(self._setTimeText, self)

	self._characterCell = nil
end

function M:bindEvents()
	self.btn_rolePreview:AddClickListener(self._onRolePreview, self)
	self.btn_btnStartBattle:AddClickListener(self._onStartBattle, self)
	self.btn_btnSearch:AddClickListener(self._onSummon, self)
end

function M:unbindEvents()
	self.btn_rolePreview:RemoveClickListener()
	self.btn_btnStartBattle:RemoveClickListener()
	self.btn_btnSearch:RemoveClickListener()
end

function M:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.OnDungeonBattleStart, self._onBattleStart, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.OnDungeonBattleStart, self._onBattleStart, self)
	end
end

function M:_onBattleStart()
	local viewName = self._viewPager:getViewPresentor():getViewName()

	ViewMgr.instance:close(viewName, false, WindowType.WindowCloseReasonType.QuickCloseType, true)
end

function M:_initRoleExperienceList()
	local tabId = self.params[1]
	local activityDataList = WelfareUtil.getActivityListByTabId(tabId)

	if not activityDataList or #activityDataList <= 0 then
		return
	end

	local reActivityDataList = {}

	for i = 1, #activityDataList do
		local data = activityDataList[i]

		if WelfareUtil.isShowActivity(data) then
			table.insert(reActivityDataList, data)
		end
	end

	if #reActivityDataList <= 0 then
		return
	end

	table.clear(self._roleCellList)
	table.clear(self._roleCellToActivityData)

	local roleChildCount = self.tr_rolesParent.childCount
	local activityCount = #reActivityDataList

	if roleChildCount < activityCount then
		for i = roleChildCount + 1, activityCount do
			local go = goutil.cloneAndSetParent(self.roleItem, self.tr_rolesParent)
			local cell = Astral.LuaComponentContainer.Add(go, RoleExperienceRoleItemCell)
		end
	end

	for i = 1, self.tr_rolesParent.childCount do
		local child = self.tr_rolesParent:GetChild(i - 1)

		if i <= activityCount then
			goutil.setActive(child.gameObject, true)

			local cell = child and Astral.LuaComponentContainer.Get(child.gameObject, RoleExperienceRoleItemCell)
			local characterId = RoleExperienceConfig.instance:getExperienceCharacterId(reActivityDataList[i]:getConfigId())
			local rewardState = self:_rewardState(reActivityDataList[i])

			cell:updateData(characterId)
			cell:updateRewardState(rewardState)
			cell:setHandler(self)
			table.insert(self._roleCellList, cell)

			self._roleCellToActivityData[cell] = reActivityDataList[i]
		else
			goutil.setActive(child.gameObject, false)
		end
	end

	goutil.setActive(self.roleItem, false)
	self:_removeFirstRedPoint(reActivityDataList)
end

function M:_removeFirstRedPoint(reActivityDataList)
	if not reActivityDataList then
		return
	end

	local reRemoveActIdList = {}

	for i = 1, #reActivityDataList do
		local data = reActivityDataList[i]

		if not data:getRedDotActive() then
			local key = GameEnum.RedPointEnum.Activity .. "_" .. data:getId()

			if RedDotModel.instance:getDotIsActive(key) then
				table.insert(reRemoveActIdList, data:getId())
			end
		end
	end

	if #reRemoveActIdList > 0 then
		RedDotAgent.instance:sendRemoveRedPointRequest(GameEnum.RedPointEnum.Activity, reRemoveActIdList)
	end
end

function M:onClickHeroItem(characterCell)
	if not characterCell or not self._roleCellList or #self._roleCellList <= 0 then
		return
	end

	if self._characterCell == characterCell then
		return
	end

	self._characterCell = characterCell

	for i = 1, #self._roleCellList do
		if self._roleCellList[i] == characterCell then
			self._roleCellList[i]:setSelected(true)

			self._selectIndex = i

			self:_updateActivityBaseInfo(self._roleCellToActivityData[characterCell])
		else
			self._roleCellList[i]:setSelected(false)
		end
	end

	WelfareUtil.playWelfareViewAnim(self.mainGO, "open")
end

function M:_updateActivityBaseInfo(activityData)
	if not activityData then
		return
	end

	local roleExperienceCode = activityData:getConfigId()
	local recfg = RoleExperienceConfig.instance:getRoleExperienceCfg(roleExperienceCode)
	local characterCfg = CharacterConfig.instance:getCharacterItemInfo(recfg.heroId)
	local characterInfoCfg = PastInfoConfig.instance:getCharacterInfo(recfg.heroId)

	self.text_txtCondition.text = recfg.condition

	self:_setTimeText()
	removetimer(self._setTimeText, self)
	settimer(60, self._setTimeText, self, true)

	self.text_roleName.text = characterInfoCfg.name

	IconLoader.setSprite(self.img_imgCareerDi, IconType.Skinlib, CharacterCOUtil.colorType2IconName(characterCfg.colorType))
	IconLoader.setSprite(self.img_imgCareerSign, IconType.Skinlib, CharacterCOUtil.career2IconName(characterCfg.career))

	local qualityIconName = CommEnum.CharacterQuality2TabIcon[characterCfg.quality]

	IconLoader.setSprite(self.img_quality, IconType.DynSpriteAtlas_CharacterSystem_Com, qualityIconName)
	self._imgRole:SetImage(self:_getRoleImgUrl(recfg.roleImg))

	self._textTitle.text = recfg.name

	self:_updateReward(activityData)
end

function M:_updateReward(activityData)
	local rewordData = RoleExperienceConfig.instance:getExperienceReward(activityData:getConfigId())

	if not rewordData then
		return
	end

	local rewardState = self:_rewardState(activityData)

	self._roleExperienceItemCell:updateData(activityData:getId(), rewordData.code, rewordData.num, isLock, rewardState)
end

function M:_rewardState(activityData)
	local dynConfig = activityData._dynConfig
	local isLock = true
	local rewardState = CommEnum.RewardEnum.CanNotGot

	if dynConfig then
		isLock = dynConfig.unlocked == 0

		if isLock == false then
			rewardState = dynConfig.rewardInfo == 0 and CommEnum.RewardEnum.CanGot or CommEnum.RewardEnum.HasGot
		end
	end

	return rewardState
end

function M:_getConfig()
	local cfgId = self._roleCellToActivityData[self._roleCellList[self._selectIndex]]:getConfigId()

	return RoleExperienceConfig.instance:getRoleExperienceCfg(cfgId)
end

function M:_onRolePreview()
	local roleExperienceCfg = self:_getConfig()

	CharacterUtil.openCharacterPreviewView(roleExperienceCfg.heroId)
end

function M:_onStartBattle()
	local txtBtn = goutil.findChildTextComponent(self.btn_btnStartBattle.gameObject, "normal/Text1")

	UserUtil.uploadActivityTabBuryPoint(UserUtil.activityFirstTabName, UserUtil.activitySecondTabName, txtBtn and txtBtn.text or "")

	local roleExperienceCfg = self:_getConfig()

	if roleExperienceCfg then
		local hasDungeon = DungeonConfig.instance:getDungeonCfgById(roleExperienceCfg.levelId) ~= nil

		if not hasDungeon then
			printError(string.format("找不到ID为 %s 的关卡", roleExperienceCfg.levelId))

			return
		end

		local info = {}

		info.dungeonCode = roleExperienceCfg.levelId
		info.afflatusBuff = false
		info.isShowPlot = false
		info.multiCount = 1
		info.gamePlay = BattleEnum.GamePlayType.NORMAL

		DungeonController.instance:startDungeonBattle(info)
	end
end

function M:_onSummon()
	local txtBtn = goutil.findChildTextComponent(self.btn_btnSearch.gameObject, "normal/Text1")

	UserUtil.uploadActivityTabBuryPoint(UserUtil.activityFirstTabName, UserUtil.activitySecondTabName, txtBtn and txtBtn.text or "")

	local roleExperienceCfg = self:_getConfig()

	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, roleExperienceCfg.jumpId)
end

function M:_onReceiveReward()
	local roleCell = self._roleCellList[self._selectIndex]
	local activityData = self._roleCellToActivityData[roleCell]
	local rewardState = self:_rewardState(activityData)

	roleCell:updateRewardState(rewardState)
	self:_updateReward(activityData)
end

function M:_setTimeText()
	local activityData = self._roleCellToActivityData[self._roleCellList[self._selectIndex]]

	if not activityData then
		return
	end

	local residueTime = activityData:getLeftSeconds()

	residueTime = residueTime < 0 and 0 or residueTime
	self.text_residueTime.text = TextFormatter.formatFullExpireTime(residueTime)
end

function M:_getRoleImgUrl(imgName)
	return string.format("ui/bigbg/wekfare/role_experience/role_experience_dynamic/%s.png", imgName)
end

function M:destroyUI()
	M.super.destroyUI(self)

	self._roleCellList = nil
	self._roleCellToActivityData = nil
	self._selectIndex = nil
	self._roleExperienceItemCell = nil
end

return M

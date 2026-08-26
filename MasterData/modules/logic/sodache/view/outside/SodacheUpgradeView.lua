-- chunkname: @modules/logic/sodache/view/outside/SodacheUpgradeView.lua

module("modules.logic.sodache.view.outside.SodacheUpgradeView", package.seeall)

local SodacheUpgradeView = class("SodacheUpgradeView", BaseView)

function SodacheUpgradeView:onInitView()
	self._simageBuild = gohelper.findChildSingleImage(self.viewGO, "root/left/#simage_Build")
	self._txtName = gohelper.findChildText(self.viewGO, "root/left/#txt_Name")
	self._scrollBuildingDesc = gohelper.findChildScrollRect(self.viewGO, "root/left/#scroll_BuildingDesc")
	self._txtBuildingDesc = gohelper.findChildText(self.viewGO, "root/left/#scroll_BuildingDesc/Viewport/Content/#txt_BuildingDesc")
	self._goLevel = gohelper.findChild(self.viewGO, "root/left/#go_Level")
	self._txtCurLvl = gohelper.findChildText(self.viewGO, "root/left/#go_Level/#txt_CurLvl")
	self._goArrow = gohelper.findChild(self.viewGO, "root/left/#go_Level/#go_Arrow")
	self._txtNextLvl = gohelper.findChildText(self.viewGO, "root/left/#go_Level/#txt_NextLvl")
	self._scrollTask = gohelper.findChildScrollRect(self.viewGO, "root/right/#scroll_Task")
	self._goTaskItem = gohelper.findChild(self.viewGO, "root/right/#scroll_Task/Viewport/Content/#go_TaskItem")
	self._txtUpgradeDesc = gohelper.findChildText(self.viewGO, "root/right/effect/#txt_UpgradeDesc")
	self._goBuild = gohelper.findChild(self.viewGO, "root/right/btn/#go_Build")
	self._btnBuild = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/btn/#go_Build/#btn_Build")
	self._goBuildGray = gohelper.findChild(self.viewGO, "root/right/btn/#go_Build/#go_BuildGray")
	self._goUpgrade = gohelper.findChild(self.viewGO, "root/right/btn/#go_Upgrade")
	self._btnUpgrade = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/btn/#go_Upgrade/#btn_Upgrade")
	self._goUpgradeGray = gohelper.findChild(self.viewGO, "root/right/btn/#go_Upgrade/#go_UpgradeGray")
	self._goMax = gohelper.findChild(self.viewGO, "root/right/btn/#go_Max")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SodacheUpgradeView:addEvents()
	self._btnBuild:AddClickListener(self._btnBuildOnClick, self)
	self._btnUpgrade:AddClickListener(self._btnUpgradeOnClick, self)
end

function SodacheUpgradeView:removeEvents()
	self._btnBuild:RemoveClickListener()
	self._btnUpgrade:RemoveClickListener()
end

function SodacheUpgradeView:onClickModalMask()
	self:closeThis()
end

function SodacheUpgradeView:_btnBuildOnClick()
	if self.canClick then
		SodacheOutsideRpc.instance:sendSodacheBuildingUpgrade(self.data.type)
		self:closeThis()
	end
end

function SodacheUpgradeView:_btnUpgradeOnClick()
	if self.canClick then
		SodacheOutsideRpc.instance:sendSodacheBuildingUpgrade(self.data.type)
		self:closeThis()
	end
end

function SodacheUpgradeView:_editableInitView()
	gohelper.setActive(self._goTaskItem, false)

	self.canClick = true
end

function SodacheUpgradeView:onOpen()
	self.data = self.viewParam
	self._txtBuildingDesc.text = self.data.baseCo.buildingDesc
	self._txtCurLvl.text = string.format("Lv.%s", self.data.level)

	local canBuild = self.data.level == 0
	local isMax = self.data.level == self.data.maxLevel
	local canUpgrade = not isMax and not canBuild

	if isMax then
		self._txtName.text = self.data.co.name

		self._simageBuild:LoadImage(ResUrl.getSodacheSingleBg(self.data.co.icon, "build"))

		local buildCfgs = lua_sodache_building.configDict[self.data.type]
		local effectStr

		for k, config in ipairs(buildCfgs) do
			effectStr = k == 1 and string.format("Lv.%d.%s", k, config.unlockDesc) or string.format("%s<br>Lv.%d.%s", effectStr, k, config.unlockDesc)
		end

		self._txtUpgradeDesc.text = effectStr

		gohelper.setActive(self._txtNextLvl, false)
		gohelper.setActive(self._goArrow, false)
	else
		local nextCfg = lua_sodache_building.configDict[self.data.type][self.data.level + 1]

		self._txtName.text = nextCfg.name

		self:refreshTask(nextCfg.unlockPram)

		self._txtUpgradeDesc.text = nextCfg.unlockDesc

		self._simageBuild:LoadImage(ResUrl.getSodacheSingleBg(nextCfg.icon, "build"))

		if canUpgrade then
			local nextLvl = self.data.level + 1

			self._txtNextLvl.text = string.format("Lv.%s", nextLvl)

			gohelper.setActive(self._txtNextLvl, true)
			gohelper.setActive(self._goArrow, true)
		end
	end

	gohelper.setActive(self._goLevel, canUpgrade or isMax)
	gohelper.setActive(self._scrollTask, not isMax)
	gohelper.setActive(self._goBuild, canBuild)
	gohelper.setActive(self._goUpgrade, canUpgrade)
	gohelper.setActive(self._goMax, isMax)
	gohelper.setActive(self._goBuildGray, not self.canClick)
	gohelper.setActive(self._goUpgradeGray, not self.canClick)
end

function SodacheUpgradeView:refreshTask(unlockPram)
	if string.nilorempty(unlockPram) then
		gohelper.setActive(self._scrollTask, false)

		return
	end

	local unlockIds = string.splitToNumber(unlockPram, "#")

	for _, v in ipairs(unlockIds) do
		local unlockCfg = lua_sodache_unlock.configDict[v]
		local go = gohelper.cloneInPlace(self._goTaskItem)
		local txtTask = gohelper.findChildText(go, "txt_Task")
		local imageIcon = gohelper.findChildImage(go, "progress/image_Icon")
		local txtCurrent = gohelper.findChildText(go, "progress/txt_Current")
		local txtTotal = gohelper.findChildText(go, "progress/txt_Total")
		local goJump = gohelper.findChild(go, "go_Jump")
		local goFinish = gohelper.findChild(go, "go_Finish")

		txtTask.text = unlockCfg.desc

		local curNum, totalNum, itemId = SodacheUtil.checkUnlockCondition(unlockCfg.condition)

		txtCurrent.text = totalNum <= curNum and curNum or string.format("<color=#ce4949>%d</color>", curNum)
		txtTotal.text = totalNum

		gohelper.setActive(imageIcon, itemId)
		gohelper.setActive(goJump, curNum < totalNum)
		gohelper.setActive(goFinish, totalNum <= curNum)

		if curNum < totalNum then
			self.canClick = false
		end

		gohelper.setActive(go, true)
	end
end

function SodacheUpgradeView.BuildEffectDesc(configs)
	local txt

	for k, v in ipairs(configs) do
		txt = k == 1 and string.format("Lv.%s:%s", k, v.unlockDesc) or string.format("%s<br>Lv.%s:%s", txt, k, v.unlockDesc)
	end

	return txt
end

return SodacheUpgradeView

-- chunkname: @modules/logic/survival/view/shelter/ShelterManagerInfoView.lua

module("modules.logic.survival.view.shelter.ShelterManagerInfoView", package.seeall)

local ShelterManagerInfoView = class("ShelterManagerInfoView", LuaCompBase)

function ShelterManagerInfoView.getView(prefabRes, parentGO, name)
	local go = gohelper.clone(prefabRes, parentGO, name)

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, ShelterManagerInfoView)
end

function ShelterManagerInfoView:init(go)
	self.viewGO = go
	self.transform = go.transform
	self.goRoot = gohelper.findChild(self.viewGO, "root")
	self.btnClose = gohelper.findChildButtonWithAudio(self.goRoot, "#btn_close")

	gohelper.setActive(self.btnClose, false)
	self:initNpc()
	self:initbuild()

	self.goEmpty = gohelper.findChild(self.goRoot, "#go_empty")
	self.animator = self.viewGO:GetComponent(gohelper.Type_Animator)
end

function ShelterManagerInfoView:initNpc()
	self.goNpc = gohelper.findChild(self.goRoot, "#go_npc")
	self.imgNpcQuality = gohelper.findChildImage(self.goNpc, "top/middle/npc/#image_quality")
	self.imgNpcChess = gohelper.findChildSingleImage(self.goNpc, "top/middle/npc/#image_chess")
	self.txtNpcName = gohelper.findChildTextMesh(self.goNpc, "top/middle/npc/#txt_name")
	self.goNpcReset = gohelper.findChild(self.goNpc, "top/left/rest")
	self.btnNpcLeave = gohelper.findChildButtonWithAudio(self.goNpc, "bottom/#btn_leave")
	self.btnNpcGoto = gohelper.findChildButtonWithAudio(self.goNpc, "bottom/#btn_goto")
	self.btnNpcReset = gohelper.findChildButtonWithAudio(self.goNpc, "bottom/#btn_rest")
	self.btnNpcJoin = gohelper.findChildButtonWithAudio(self.goNpc, "bottom/#btn_join")
	self.btnNpcSelect = gohelper.findChildButtonWithAudio(self.goNpc, "bottom/#btn_select")
	self.btnNpcUnSelect = gohelper.findChildButtonWithAudio(self.goNpc, "bottom/#btn_unSelect")
	self.goNpcAttrItem = gohelper.findChild(self.goNpc, "scroll_base/Viewport/Content/#go_attrs/#go_baseitem")

	gohelper.setActive(self.goNpcAttrItem, false)

	self.txtNpcInfo = gohelper.findChildTextMesh(self.goNpc, "scroll_base/Viewport/Content/#txt_info")
	self.npcAttrList = {}
	self.goNpcCost = gohelper.findChild(self.goNpc, "right/tips")
	self.txtNpcCostTips = gohelper.findChildTextMesh(self.goNpcCost, "#txt_tips")
end

function ShelterManagerInfoView:initbuild()
	self.goBuild = gohelper.findChild(self.goRoot, "#go_build")
	self.imageBuild = gohelper.findChildImage(self.goBuild, "top/middle/build/#image_build")
	self.simageBuild = gohelper.findChildSingleImage(self.goBuild, "top/middle/build/#image_build")
	self.goImageBuild = gohelper.findChild(self.goBuild, "top/middle/build/#image_build")
	self.txtBuildName = gohelper.findChildTextMesh(self.goBuild, "top/middle/build/#txt_name")
	self.goBuildDestroyed = gohelper.findChild(self.goBuild, "top/middle/build/#go_Destroyed")
	self.goBuildLocked = gohelper.findChild(self.goBuild, "top/middle/build/#go_Locked")
	self.btnBuildLevup = gohelper.findChildButtonWithAudio(self.goBuild, "bottom/#btn_LevelUp")
	self.btnBuild = gohelper.findChildButtonWithAudio(self.goBuild, "bottom/#btn_build")
	self.btnBuildRepair = gohelper.findChildButtonWithAudio(self.goBuild, "bottom/#btn_repair")
	self.goBuildLock = gohelper.findChild(self.goBuild, "bottom/#go_lock")
	self.goBuildLockBuild = gohelper.findChild(self.goBuild, "bottom/#go_lock/txt_build")
	self.goBuildLockLevup = gohelper.findChild(self.goBuild, "bottom/#go_lock/txt_levup")
	self.txtBuildLock = gohelper.findChildTextMesh(self.goBuild, "bottom/#go_lock/#txt_lock")
	self.goBuildCost = gohelper.findChild(self.goBuild, "bottom/#go_num")
	self.txtBuildCost = gohelper.findChildTextMesh(self.goBuild, "bottom/#go_num/#txt_count")
	self.goBuildAttrLevelup = gohelper.findChild(self.goBuild, "scroll_base/Viewport/Content/#go_attrs/#go_LevelUp")
	self.txtBuildLevel1 = gohelper.findChildTextMesh(self.goBuildAttrLevelup, "#image_title/#txt_level1")
	self.txtBuildLevel2 = gohelper.findChildTextMesh(self.goBuildAttrLevelup, "#image_title/#txt_level2")
	self.goBuildAttrLevel = gohelper.findChild(self.goBuild, "scroll_base/Viewport/Content/#go_attrs/#go_Level")
	self.txtBuildLevel = gohelper.findChildTextMesh(self.goBuildAttrLevel, "#image_title/#txt_level")
	self.txtBuildAttrCurrentItem = gohelper.findChildTextMesh(self.goBuild, "scroll_base/Viewport/Content/#go_current/#txt_current")
	self.goBuildAttrNext = gohelper.findChild(self.goBuild, "scroll_base/Viewport/Content/#go_next")
	self.txtBuildAttrNextItem = gohelper.findChildTextMesh(self.goBuild, "scroll_base/Viewport/Content/#go_next/#txt_next")
end

function ShelterManagerInfoView:addEventListeners()
	self.addClickCb(self, self.btnClose, self.onClickBtnClose, self)
	self.addClickCb(self, self.btnNpcGoto, self.onClickBtnNpcGoto, self)
	self.addClickCb(self, self.btnNpcReset, self.onClickBtnNpcReset, self)
	self.addClickCb(self, self.btnNpcJoin, self.onClickBtnNpcJoin, self)
	self.addClickCb(self, self.btnBuildLevup, self.onClickBtnBuildLevup, self)
	self.addClickCb(self, self.btnBuildRepair, self.onClickBtnBuildRepair, self)
	self.addClickCb(self, self.btnBuild, self.onClickBtnBuild, self)
	self.addClickCb(self, self.btnNpcSelect, self.onClickBtnNpcSelect, self)
	self.addClickCb(self, self.btnNpcLeave, self.onClickBtnNpcLeave, self)
	self.addClickCb(self, self.btnNpcUnSelect, self.onClickBtnNpcUnSelect, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, self.onShelterBagUpdate, self)
end

function ShelterManagerInfoView:removeEventListeners()
	self:removeClickCb(self.btnClose)
	self:removeClickCb(self.btnNpcGoto)
	self:removeClickCb(self.btnNpcReset)
	self:removeClickCb(self.btnNpcJoin)
	self:removeClickCb(self.btnBuildLevup)
	self:removeClickCb(self.btnBuildRepair)
	self:removeClickCb(self.btnBuild)
	self:removeClickCb(self.btnNpcSelect)
	self:removeClickCb(self.btnNpcLeave)
	self:removeClickCb(self.btnNpcUnSelect)
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, self.onShelterBagUpdate, self)
end

function ShelterManagerInfoView:onShelterBagUpdate()
	self:refreshView()
end

function ShelterManagerInfoView:onClickBtnClose()
	return
end

function ShelterManagerInfoView:onClickBtnNpcLeave()
	SurvivalShelterTentListModel.instance:quickSelectNpc(self.showId)
end

function ShelterManagerInfoView:onClickBtnNpcJoin()
	SurvivalShelterTentListModel.instance:quickSelectNpc(self.showId)
end

function ShelterManagerInfoView:onClickBtnNpcSelect()
	SurvivalShelterChooseNpcListModel.instance:setSelectNpcToPos(self.showId)
	self:setNextSelectPos()
end

function ShelterManagerInfoView:onClickBtnNpcUnSelect()
	local selectIndex = SurvivalShelterChooseNpcListModel.instance:npcIdIsSelect(self.showId)

	SurvivalShelterChooseNpcListModel.instance:setSelectNpcToPos(nil, selectIndex)
	self:setNextSelectPos()
end

function ShelterManagerInfoView:setNextSelectPos()
	local selectPos = SurvivalShelterChooseNpcListModel.instance:getNextCanSelectPosIndex()

	if selectPos ~= nil then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnSetNpcSelectPos, selectPos)
	end
end

function ShelterManagerInfoView:onClickBtnNpcReset()
	ViewMgr.instance:closeView(ViewName.ShelterNpcManagerView)
	ViewMgr.instance:openView(ViewName.ShelterTentManagerView)
end

function ShelterManagerInfoView:onClickBtnNpcGoto()
	SurvivalMapHelper.instance:gotoNpc(self.showId)
end

function ShelterManagerInfoView:onClickBtnBuildLevup()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local buildingInfo = weekInfo:getBuildingInfo(self.showId)

	if not buildingInfo then
		return
	end

	local nextConfig = SurvivalConfig.instance:getBuildingConfig(buildingInfo.buildingId, buildingInfo.level + 1, true)
	local isEnough, itemId, itemCount, curCount = weekInfo:getBag(SurvivalEnum.ItemSource.Shelter):costIsEnough(nextConfig.lvUpCost, buildingInfo, SurvivalEnum.AttrType.BuildCost)

	if not isEnough then
		local itemConfig = lua_survival_item.configDict[itemId]

		GameFacade.showToast(ToastEnum.DiamondBuy, itemConfig.name)

		return
	end

	SurvivalWeekRpc.instance:sendSurvivalUpgradeRequest(buildingInfo.id)
end

function ShelterManagerInfoView:onClickBtnBuild()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local buildingInfo = weekInfo:getBuildingInfo(self.showId)

	if not buildingInfo then
		return
	end

	local nextConfig = SurvivalConfig.instance:getBuildingConfig(buildingInfo.buildingId, buildingInfo.level + 1, true)
	local isEnough, itemId, itemCount, curCount = weekInfo:getBag(SurvivalEnum.ItemSource.Shelter):costIsEnough(nextConfig.lvUpCost, buildingInfo, SurvivalEnum.AttrType.BuildCost)

	if not isEnough then
		local itemConfig = lua_survival_item.configDict[itemId]

		GameFacade.showToast(ToastEnum.DiamondBuy, itemConfig.name)

		return
	end

	SurvivalWeekRpc.instance:sendSurvivalBuildRequest(buildingInfo.id)
end

function ShelterManagerInfoView:onClickBtnBuildRepair()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local buildingInfo = weekInfo:getBuildingInfo(self.showId)

	if not buildingInfo then
		return
	end

	local curConfig = SurvivalConfig.instance:getBuildingConfig(buildingInfo.buildingId, buildingInfo.level, true)
	local isEnough, itemId, itemCount, curCount = weekInfo:getBag(SurvivalEnum.ItemSource.Shelter):costIsEnough(curConfig.repairCost, buildingInfo, SurvivalEnum.AttrType.RepairCost)

	if not isEnough then
		local itemConfig = lua_survival_item.configDict[itemId]

		GameFacade.showToast(ToastEnum.DiamondBuy, itemConfig.name)

		return
	end

	SurvivalWeekRpc.instance:sendSurvivalRepairRequest(buildingInfo.id)
end

function ShelterManagerInfoView:refreshParam(param)
	self.viewParam = param or {}
	self.showType = self.viewParam.showType or SurvivalEnum.InfoShowType.None
	self.showId = self.viewParam.showId or 0
	self.otherParam = self.viewParam.otherParam or {}

	self:refreshAnimName()
	self:refreshView()
end

function ShelterManagerInfoView:refreshAnimName()
	local isFirstOpen = not self.showId

	self.animName = nil

	if isFirstOpen then
		self.animName = UIAnimationName.Open
	else
		local isSwitch = self.showId ~= self.lastShowId or self.showType ~= self.lastShowType

		if isSwitch then
			self.animName = UIAnimationName.Switch
			self.delayRefreshTime = 0.167
		end
	end

	self.lastShowId = self.showId
	self.lastShowType = self.showType
end

function ShelterManagerInfoView:refreshView()
	if self.animName then
		self.animator:Play(self.animName, 0, 0)
	end

	self.animName = nil

	TaskDispatcher.cancelTask(self.refreshInfo, self)

	if self.delayRefreshTime then
		TaskDispatcher.runDelay(self.refreshInfo, self, self.delayRefreshTime)
	else
		self:refreshInfo()
	end

	self.delayRefreshTime = nil
end

function ShelterManagerInfoView:refreshInfo()
	if self.showType == SurvivalEnum.InfoShowType.Building then
		self:refreshBuilding()
	elseif self.showType == SurvivalEnum.InfoShowType.Npc or self.showType == SurvivalEnum.InfoShowType.NpcOnlyConfig then
		self:refreshNpc()
	else
		self:showEmpty()
	end
end

function ShelterManagerInfoView:refreshBuilding()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local buildingInfo = weekInfo:getBuildingInfo(self.showId)

	if not buildingInfo then
		self:showEmpty()

		return
	end

	gohelper.setActive(self.goBuild, true)
	gohelper.setActive(self.goNpc, false)
	gohelper.setActive(self.goEmpty, false)

	local curLev = buildingInfo.level
	local nextLev = curLev + 1
	local curConfig = SurvivalConfig.instance:getBuildingConfig(buildingInfo.buildingId, curLev, true)
	local nextConfig = SurvivalConfig.instance:getBuildingConfig(buildingInfo.buildingId, nextLev, true)

	self.txtBuildName.text = buildingInfo.baseCo.name

	local isUnLock, reason = weekInfo:isBuildingUnlock(buildingInfo.buildingId, nextLev, true)
	local isUnBuild = not buildingInfo:isBuild()
	local isDestroy = buildingInfo.status == SurvivalEnum.BuildingStatus.Destroy

	gohelper.setActive(self.goBuildDestroyed, isDestroy)
	gohelper.setActive(self.goBuildLocked, not isUnLock and isUnBuild)
	self.simageBuild:LoadImage(buildingInfo.baseCo.icon, self.onLoadedImage, self)
	ZProj.UGUIHelper.SetGrayscale(self.goImageBuild, not isUnLock and isUnBuild)
	gohelper.setActive(self.btnBuildLevup, false)
	gohelper.setActive(self.btnBuild, false)
	gohelper.setActive(self.btnBuildRepair, false)
	gohelper.setActive(self.goBuildLock, false)
	gohelper.setActive(self.goBuildCost, false)

	if isUnLock then
		if isUnBuild then
			gohelper.setActive(self.btnBuild, true)
			self:refreshBuildCost(nextConfig and nextConfig.lvUpCost, buildingInfo, SurvivalEnum.AttrType.BuildCost)
		elseif isDestroy then
			gohelper.setActive(self.btnBuildRepair, true)
			self:refreshBuildCost(curConfig and curConfig.repairCost, buildingInfo, SurvivalEnum.AttrType.RepairCost)
		else
			gohelper.setActive(self.btnBuildLevup, nextConfig ~= nil)
			self:refreshBuildCost(nextConfig and nextConfig.lvUpCost, buildingInfo, SurvivalEnum.AttrType.BuildCost)
		end
	else
		gohelper.setActive(self.goBuildLock, true)

		self.txtBuildLock.text = reason

		gohelper.setActive(self.goBuildLockBuild, isUnBuild)
		gohelper.setActive(self.goBuildLockLevup, not isUnBuild)
	end

	local hasLevup = buildingInfo.level > 0 and nextConfig ~= nil and not isDestroy

	gohelper.setActive(self.goBuildAttrLevelup, hasLevup)
	gohelper.setActive(self.goBuildAttrLevel, not hasLevup)
	gohelper.setActive(self.goBuildAttrNext, hasLevup)

	local var_23_0

	if curConfig then
		var_23_0 = curConfig.desc

		if not curConfig.desc then
			if nextConfig then
				var_23_0 = nextConfig.desc or ""
			end
		end
	end

	self.txtBuildAttrCurrentItem.text = var_23_0

	if hasLevup then
		self.txtBuildAttrNextItem.text = nextConfig.desc
		self.txtBuildLevel1.text = string.format("Lv.%s", curLev)
		self.txtBuildLevel2.text = string.format("Lv.%s", nextLev)
	else
		self.txtBuildLevel.text = string.format("Lv.%s", curLev)
	end
end

function ShelterManagerInfoView:onLoadedImage()
	self.imageBuild:SetNativeSize()
end

function ShelterManagerInfoView:refreshBuildCost(cost, attrObj, attrType)
	if string.nilorempty(cost) then
		gohelper.setActive(self.goBuildCost, false)
	else
		gohelper.setActive(self.goBuildCost, true)

		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
		local isEnough, itemId, itemCount, curCount = weekInfo:getBag(SurvivalEnum.ItemSource.Shelter):costIsEnough(cost, attrObj, attrType)

		self.txtBuildCost.text = isEnough and string.format("%s/%s", curCount, itemCount) or string.format("<color=#D74242>%s</color>/%s", curCount, itemCount)
	end
end

function ShelterManagerInfoView:refreshNpc()
	if self.showType == SurvivalEnum.InfoShowType.NpcOnlyConfig then
		self:_refreshNpcOnlyConfig()

		return
	end

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local npcInfo = weekInfo:getNpcInfo(self.showId)

	if not npcInfo then
		self:showEmpty()

		return
	end

	gohelper.setActive(self.goBuild, false)
	gohelper.setActive(self.goNpc, true)
	gohelper.setActive(self.goEmpty, false)

	local tentBuildingId = self.otherParam.tentBuildingId
	local inTent = tentBuildingId ~= nil and tentBuildingId ~= 0
	local config = npcInfo.co

	self.txtNpcName.text = config.name

	SurvivalUnitIconHelper.instance:setNpcIcon(self.imgNpcChess, config.headIcon)
	UISpriteSetMgr.instance:setSurvivalSprite(self.imgNpcQuality, string.format("survival_bag_itemquality2_%s", config.rare))

	self.txtNpcInfo.text = config.npcDesc

	local buildingId, buildingPos = weekInfo:getNpcPostion(self.showId)
	local isReset = buildingId ~= nil

	gohelper.setActive(self.goNpcReset, not inTent and isReset)
	gohelper.setActive(self.btnNpcGoto, not inTent and isReset)
	gohelper.setActive(self.btnNpcReset, not inTent and not isReset)

	local _, tagList = SurvivalConfig.instance:getNpcConfigTag(self.showId)

	for i = 1, math.max(#tagList, #self.npcAttrList) do
		local item = self:getNpcAttrItem(i)

		self:refreshNpcAttrItem(item, tagList[i])
	end

	gohelper.setActive(self.btnNpcJoin, inTent and tentBuildingId ~= buildingId)
	gohelper.setActive(self.btnNpcLeave, inTent and tentBuildingId == buildingId)
	self:refreshNpcCost(config)
end

function ShelterManagerInfoView:refreshNpcCost(config)
	if not config then
		gohelper.setActive(self.goNpcCost, false)

		return
	end

	gohelper.setActive(self.goNpcCost, true)

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local costList = string.split(config.cost, "#")
	local cost = string.splitToNumber(costList[2], ":")

	if not cost[2] then
		local itemCount = 0
		local costNum = weekInfo:getAttr(SurvivalEnum.AttrType.NpcFoodCost, itemCount)

		self.txtNpcCostTips.text = formatLuaLang("ShelterManagerInfoView_npc_foodcost", costNum)
	end
end

function ShelterManagerInfoView:_refreshNpcOnlyConfig()
	gohelper.setActive(self.goBuild, false)
	gohelper.setActive(self.goNpc, true)
	gohelper.setActive(self.goEmpty, false)

	local config = SurvivalConfig.instance:getNpcConfig(self.showId)

	if config then
		self.txtNpcName.text = config.name

		if not string.nilorempty(config.headIcon) then
			SurvivalUnitIconHelper.instance:setNpcIcon(self.imgNpcChess, config.headIcon)
		end

		UISpriteSetMgr.instance:setSurvivalSprite(self.imgNpcQuality, string.format("survival_bag_itemquality2_%s", config.rare))

		self.txtNpcInfo.text = config.npcDesc
	end

	gohelper.setActive(self.goNpcReset, false)
	gohelper.setActive(self.btnNpcGoto, false)
	gohelper.setActive(self.btnNpcReset, false)
	gohelper.setActive(self.btnNpcJoin, false)

	local _, tagList = SurvivalConfig.instance:getNpcConfigTag(self.showId)

	for i = 1, math.max(#tagList, #self.npcAttrList) do
		local item = self:getNpcAttrItem(i)

		self:refreshNpcAttrItem(item, tagList[i])
	end

	if self.otherParam then
		if not self.otherParam.showSelect then
			local showSelect = true

			if self.otherParam then
				if not self.otherParam.showUnSelect then
					local showUnSelect = true
					local quickSelect = SurvivalShelterChooseNpcListModel.instance:isQuickSelect()

					if showSelect then
						local selectIndex = SurvivalShelterChooseNpcListModel.instance:npcIdIsSelect(self.showId)

						gohelper.setActive(self.btnNpcSelect, selectIndex == nil and not quickSelect)
					end

					if showUnSelect then
						local selectIndex = SurvivalShelterChooseNpcListModel.instance:npcIdIsSelect(self.showId)

						gohelper.setActive(self.btnNpcUnSelect, selectIndex ~= nil and not quickSelect)
					end

					self:refreshNpcCost()
				end
			end
		end
	end
end

function ShelterManagerInfoView:getNpcAttrItem(index)
	local item = self.npcAttrList[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self.goNpcAttrItem, tostring(index))
		item.imgTitle = gohelper.findChildImage(item.go, "#image_title")
		item.txtTitle = gohelper.findChildTextMesh(item.go, "#image_title/#txt_title")
		item.txtDesc = gohelper.findChildTextMesh(item.go, "layout/#go_decitem/#txt_desc")
		self.npcAttrList[index] = item
	end

	return item
end

function ShelterManagerInfoView:refreshNpcAttrItem(item, tagId)
	if not tagId then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	local config = lua_survival_tag.configDict[tagId]

	if config == nil then
		logError("tagId is nil" .. tagId)

		return
	end

	item.txtTitle.text = config.name
	item.txtDesc.text = config.desc

	UISpriteSetMgr.instance:setSurvivalSprite(item.imgTitle, string.format("survivalpartnerteam_attrbg%s", config.color))
end

function ShelterManagerInfoView:showEmpty()
	gohelper.setActive(self.goBuild, false)
	gohelper.setActive(self.goNpc, false)
	gohelper.setActive(self.goEmpty, true)
end

function ShelterManagerInfoView:onDestroy()
	self.simageBuild:UnLoadImage()
	TaskDispatcher.cancelTask(self.refreshInfo, self)
end

return ShelterManagerInfoView

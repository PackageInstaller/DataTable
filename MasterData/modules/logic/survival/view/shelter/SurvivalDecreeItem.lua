-- chunkname: @modules/logic/survival/view/shelter/SurvivalDecreeItem.lua

module("modules.logic.survival.view.shelter.SurvivalDecreeItem", package.seeall)

local SurvivalDecreeItem = class("SurvivalDecreeItem", ListScrollCellExtend)

function SurvivalDecreeItem:onInitView()
	self.goHas = gohelper.findChild(self.viewGO, "#go_Has")
	self.goDescer = gohelper.findChild(self.viewGO, "#go_Has/#scroll_Descr")
	self.goDescItem = gohelper.findChild(self.viewGO, "#go_Has/#scroll_Descr/Viewport/Content/goItem")
	self.btnVote = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Has/#btn_Vote")
	self.goFinished = gohelper.findChild(self.viewGO, "#go_Has/#btn_Finished")
	self.goAdd = gohelper.findChild(self.viewGO, "#go_Add")
	self.btnAdd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Add/#btn_Add")
	self.goLocked = gohelper.findChild(self.viewGO, "#go_Locked")
	self.txtLocked = gohelper.findChildTextMesh(self.viewGO, "#go_Locked/#go_Tips/#txt_Tips")
	self.goAnnouncement = gohelper.findChild(self.viewGO, "#go_Announcement")
	self.itemList = {}
	self.anim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.tagList = {}
end

function SurvivalDecreeItem:addEvents()
	self.addClickCb(self, self.btnAdd, self.onClickAdd, self)
	self.addClickCb(self, self.btnVote, self.onClickVote, self)
end

function SurvivalDecreeItem:removeEvents()
	self:removeClickCb(self.btnAdd)
	self:removeClickCb(self.btnVote)
end

function SurvivalDecreeItem:onClickAdd()
	if SurvivalShelterModel.instance:getWeekInfo():getDecreeBox():isCurAllPolicyNotFinish() then
		GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalDecreeNewTip, MsgBoxEnum.BoxType.Yes_No, function()
			SurvivalController.instance:openDecreeSelectView()
		end)
	else
		SurvivalController.instance:openDecreeSelectView()
	end
end

function SurvivalDecreeItem:onClickVote()
	ViewMgr.instance:closeView(ViewName.SurvivalDecreeView)

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local buildingInfo = weekInfo:getBuildingInfoByBuildType(SurvivalEnum.BuildingType.Explore)

	if buildingInfo then
		SurvivalMapHelper.instance:gotoBuilding(buildingInfo.id)
	end
end

function SurvivalDecreeItem:updateItem(index)
	self.decreeIndex = index

	local info = SurvivalShelterModel.instance:getWeekInfo():getDecreeBox():getDecreeInfo(index)

	self:onUpdateMO(info)
end

function SurvivalDecreeItem:onUpdateMO(mo)
	self.mo = mo

	self:refreshView()
end

function SurvivalDecreeItem:refreshView()
	local curStatus = self.mo and self.mo:getCurStatus() or SurvivalEnum.ShelterDecreeStatus.Normal
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local decreeNum = weekInfo:getAttr(SurvivalEnum.AttrType.DecreeNum)
	local isLocked = decreeNum < self.decreeIndex
	local isEmpty = curStatus == SurvivalEnum.ShelterDecreeStatus.Normal
	local isShowHas = not isLocked and not isEmpty
	local isShowAdd = not isLocked and isEmpty

	gohelper.setActive(self.goHas, isShowHas)
	gohelper.setActive(self.goAdd, isShowAdd)
	gohelper.setActive(self.goLocked, isLocked)
	gohelper.setActive(self.goAnnouncement, false)

	if isShowHas then
		self:refreshHas()
	end

	if isLocked then
		local buildingInfo = weekInfo:getBuildingInfoByBuildType(SurvivalEnum.BuildingType.Decree)
		local buildingConfig = buildingInfo and buildingInfo.baseCo

		if buildingConfig then
			if not buildingConfig.name then
				local buildingName = ""

				self.txtLocked.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survivalbuildingmanageview_buildinglock_reason2"), buildingName, self.decreeIndex)
			end
		end
	end
end

function SurvivalDecreeItem:refreshHas()
	local curStatus = self.mo:getCurStatus()
	local isFinish = curStatus == SurvivalEnum.ShelterDecreeStatus.Finish

	gohelper.setActive(self.btnVote, not isFinish)
	gohelper.setActive(self.goFinished, isFinish)
	gohelper.setActive(self.goAnnouncement, not isFinish)

	local list = self.mo:getCurPolicyGroup():getPolicyList()

	for i = 1, math.max(#list, #self.itemList) do
		local item = self:getItem(i)

		self:updateDescItem(item, list[i], isFinish)
	end

	self:refreshTagList(list, isFinish)
end

function SurvivalDecreeItem:getItem(index)
	local item = self.itemList[index]

	if not item then
		local go = gohelper.cloneInPlace(self.goDescItem, tostring(index))

		item = self:getUserDataTb_()
		item.go = go
		item.itemList = {}

		for i = 1, 2 do
			local descItem = self:getUserDataTb_()

			descItem.go = gohelper.findChild(go, string.format("#go_%s", i))
			descItem.txtDesc = gohelper.findChildTextMesh(descItem.go, "#txt_Descr")
			descItem.txtNum = gohelper.findChildTextMesh(descItem.go, "#go_Like/#go_Like/#txt_Num")
			descItem.goLike = gohelper.findChild(descItem.go, "#go_Like")
			item.itemList[i] = descItem
		end

		item.imageIcon = gohelper.findChildImage(self.viewGO, string.format("#go_Has/Upper/image_Icon%s", index))
		self.itemList[index] = item
	end

	return item
end

function SurvivalDecreeItem:updateDescItem(item, data, isFinish)
	gohelper.setActive(item.go, data ~= nil)

	if not data then
		return
	end

	local config = SurvivalConfig.instance:getDecreeCo(data.id)
	local curIndex = data:isFinish() and 1 or 2

	for i = 1, 2 do
		local descItem = item.itemList[i]

		gohelper.setActive(descItem.go, i == curIndex)

		if i == curIndex then
			gohelper.setActive(descItem.goLike, not isFinish)

			descItem.txtNum.text = string.format("%s/%s", data.currVoteNum, data.needVoteNum)

			local var_12_0

			if config then
				var_12_0 = config.name or ""

				local var_12_1

				if config then
					var_12_1 = config.desc or ""
				end
			end

			descItem.txtDesc.text = string.format("%s:%s", var_12_0, var_12_1)
		end
	end

	if item.imageIcon and config and config.icon then
		UISpriteSetMgr.instance:setSurvivalSprite(item.imageIcon, config.icon, true)
	end
end

function SurvivalDecreeItem:playSwitchAnim()
	if not self.mo then
		return
	end

	local curStatus = self.mo:getCurStatus()
	local realStatus = self.mo:getRealStatus()

	if curStatus == realStatus then
		return
	end

	self.anim:Play("switch", 0, 0)
	self.mo:updateCurStatus()
	TaskDispatcher.runDelay(self.refreshView, self, 0.2)
	TaskDispatcher.runDelay(self.onPlaySwitchAnimEnd, self, 0.6)
end

function SurvivalDecreeItem:onPlaySwitchAnimEnd()
	if PopupController.instance:isPause() then
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_binansuo_decision)
		PopupController.instance:setPause(ViewName.SurvivalDecreeVoteView, false)
	end
end

function SurvivalDecreeItem:refreshTagList(list, isFinish)
	if isFinish then
		return
	end

	local tagList = {}
	local tagDict = {}

	for i, v in ipairs(list) do
		local config = SurvivalConfig.instance:getDecreeCo(v.id)
		local tags = string.splitToNumber(config and config.tags, "#")

		if tags then
			for _, tag in ipairs(tags) do
				tagDict[tag] = 1
			end
		end
	end

	for k, v in pairs(tagDict) do
		table.insert(tagList, k)
	end

	table.sort(tagList, function(a, b)
		return a < b
	end)

	local maxItem = 3

	for i = 1, maxItem do
		local item = self:getTagItem(i)
		local tagId = tagList[i]
		local tagConfig = lua_survival_tag.configDict[tagId]

		gohelper.setActive(item.go, tagConfig ~= nil)

		if tagConfig then
			item.txtType.text = tagConfig.name

			local colorStr = SurvivalConst.ShelterTagColor[tagConfig.color]

			if colorStr then
				SLFramework.UGUI.GuiHelper.SetColor(item.imageType, colorStr)
			end
		end
	end
end

function SurvivalDecreeItem:getTagItem(index)
	local item = self.tagList[index]

	if not item then
		local go = gohelper.findChild(self.viewGO, string.format("#go_Has/#btn_Vote/#go_tag%s", index))

		item = self:getUserDataTb_()
		item.go = go
		item.imageType = gohelper.findChildImage(go, "#image_Type")
		item.txtType = gohelper.findChildTextMesh(go, "#txt_Type")
		self.tagList[index] = item
	end

	return item
end

function SurvivalDecreeItem:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshView, self)
	TaskDispatcher.cancelTask(self.onPlaySwitchAnimEnd, self)
end

return SurvivalDecreeItem

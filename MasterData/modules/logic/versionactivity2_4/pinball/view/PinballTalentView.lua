-- chunkname: @modules/logic/versionactivity2_4/pinball/view/PinballTalentView.lua

module("modules.logic.versionactivity2_4.pinball.view.PinballTalentView", package.seeall)

local PinballTalentView = class("PinballTalentView", BaseView)

function PinballTalentView:onInitView()
	self._fullclick = gohelper.findChildClick(self.viewGO, "#simage_FullBG")
	self._godetail = gohelper.findChild(self.viewGO, "#go_detail")
	self._txttalentname = gohelper.findChildTextMesh(self.viewGO, "#go_detail/#txt_talentname")
	self._txttalentdec = gohelper.findChildTextMesh(self.viewGO, "#go_detail/#txt_talentdec")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#go_detail/#btn_cancel")
	self._btnlight = gohelper.findChildButtonWithAudio(self.viewGO, "#go_detail/#btn_light")
	self._golightgrey = gohelper.findChild(self.viewGO, "#go_detail/#btn_light/grey")
	self._gocostitem = gohelper.findChild(self.viewGO, "#go_detail/#go_currency/go_item")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btn")
	self._gotabitem = gohelper.findChild(self.viewGO, "#go_btn/#btn_building")
	self._talentitem = gohelper.findChild(self.viewGO, "#go_talentree/#go_talenitem")
	self._talentroot = gohelper.findChild(self.viewGO, "#go_talentree/#go_talengroup")
	self._topCurrencyRoot = gohelper.findChild(self.viewGO, "#go_topright")
	self._treeAnim = gohelper.findChildAnim(self.viewGO, "#go_talentree")
end

function PinballTalentView:addEvents()
	self._fullclick:AddClickListener(self._cancelSelect, self)
	self._btncancel:AddClickListener(self._cancelSelect, self)
	self._btnlight:AddClickListener(self._learnTalent, self)
end

function PinballTalentView:removeEvents()
	self._fullclick:RemoveClickListener()
	self._btncancel:RemoveClickListener()
	self._btnlight:RemoveClickListener()
end

function PinballTalentView:onOpen()
	gohelper.setActive(self._talentitem, false)
	self:initNodeAndLine()
	self:initTab()
	self:createCurrencyItem()
end

function PinballTalentView:initTab()
	local buildingIds = PinballModel.instance:getAllTalentBuildingId()
	local datas = {}
	local selectData

	for _, id in ipairs(buildingIds) do
		local co = lua_activity178_building.configDict[VersionActivity2_4Enum.ActivityId.Pinball][id][1]
		local effect = co.effect
		local type = 1
		local effectDict = GameUtil.splitString2(effect, true) or {}

		for _, arr in pairs(effectDict) do
			if arr[1] == PinballEnum.BuildingEffectType.UnlockTalent then
				type = arr[2]

				break
			end
		end

		local data = {
			co = co,
			type = type
		}

		table.insert(datas, data)

		if self.viewParam.info.baseCo == co then
			selectData = data
		end
	end

	self._tabs = {}
	selectData = selectData or datas[1]

	gohelper.CreateObjList(self, self._createTab, datas, nil, self._gotabitem, PinballTalentTabItem)
	self:_onTabClick(selectData)
end

function PinballTalentView:_createTab(obj, data, index)
	self._tabs[index] = obj

	obj:setData(data)
	obj:setClickCall(self._onTabClick, self)
end

function PinballTalentView:_onTabClick(data)
	if data ~= self._selectData then
		self._selectData = data

		for _, obj in pairs(self._tabs) do
			obj:setSelectData(data)
		end

		self:initTalent()
		self:_refreshLineStatu()
		self:_cancelSelect()
		self._treeAnim:Play("open", 0, 0)
	end
end

function PinballTalentView:initNodeAndLine()
	local lineRoot = gohelper.findChild(self.viewGO, "#go_talentree/frame").transform
	local nodeRoot = gohelper.findChild(self.viewGO, "#go_talentree/#go_talengroup").transform

	self._lines = {}
	self._nodes = {}

	for i = 0, lineRoot.childCount - 1 do
		local child = lineRoot:GetChild(i)
		local name = child.name
		local ids = string.match(name, "^line(.+)$")

		if ids then
			local arr = string.split(ids, "_") or {}

			for _, id in ipairs(arr) do
				self._lines[id] = self._lines[id] or self:getUserDataTb_()

				local lineImage = gohelper.findChildImage(child.gameObject, "")

				table.insert(self._lines[id], lineImage)
			end
		end
	end

	for i = 0, nodeRoot.childCount - 1 do
		local child = nodeRoot:GetChild(i)
		local name = child.name
		local go = gohelper.clone(self._talentitem, child.gameObject)

		gohelper.setActive(go, true)

		self._nodes[name] = MonoHelper.addNoUpdateLuaComOnceToGo(go, PinballTalentItem)

		self.addClickCb(self, gohelper.getClick(go), self._selectTalent, self, name)
	end
end

function PinballTalentView:initTalent()
	local talentCos = PinballConfig.instance:getTalentCoByRoot(VersionActivity2_4Enum.ActivityId.Pinball, self._selectData.type)

	for _, talentCo in pairs(talentCos) do
		if self._nodes[talentCo.point] then
			self._nodes[talentCo.point]:setData(talentCo, self._selectData.co)
		end
	end

	self:_refreshLineStatu()
end

function PinballTalentView:_refreshLineStatu()
	for name, lineArr in pairs(self._lines) do
		local colorStr = (self._nodes[name] and self._nodes[name]:isActive() or nil) and true and "#914B24" or "#5F4C3F"

		for _, line in pairs(lineArr) do
			SLFramework.UGUI.GuiHelper.SetColor(line, colorStr)
		end
	end
end

function PinballTalentView:createCurrencyItem()
	local topCurrency = {
		PinballEnum.ResType.Wood,
		PinballEnum.ResType.Mine,
		PinballEnum.ResType.Stone
	}

	for _, currencyType in ipairs(topCurrency) do
		local go = self:getResInst(self.viewContainer._viewSetting.otherRes.currency, self._topCurrencyRoot)
		local comp = MonoHelper.addNoUpdateLuaComOnceToGo(go, PinballCurrencyItem)

		comp:setCurrencyType(currencyType)
	end
end

function PinballTalentView:_selectTalent(name)
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio6)

	if not self._godetail.activeSelf then
		AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio7)
	end

	gohelper.setActive(self._godetail, true)
	gohelper.setActive(self._gobtns, false)

	for nodeName, talentItem in pairs(self._nodes) do
		talentItem:setSelect(name == nodeName)

		if name == nodeName then
			local talentCo = talentItem._data
			local isActive = talentItem:isActive()
			local isCanActive = talentItem:canActive()

			self._txttalentname.text = talentCo.name
			self._txttalentdec.text = talentCo.desc

			gohelper.setActive(self._btncancel, not isActive)
			gohelper.setActive(self._btnlight, not isActive)
			gohelper.setActive(self._golightgrey, not isActive and not isCanActive)

			self._nowSelect = talentItem

			if not isActive then
				self:updateCost(talentCo.cost)
			else
				self:updateCost("")
			end
		end
	end
end

function PinballTalentView:updateCost(cost)
	local costArr = {}

	if not string.nilorempty(cost) then
		local dict = GameUtil.splitString2(cost, true)

		for _, arr in pairs(dict) do
			table.insert(costArr, {
				resType = arr[1],
				value = arr[2]
			})
		end
	end

	self._costNoEnough = nil

	gohelper.CreateObjList(self, self._createCostItem, costArr, nil, self._gocostitem)
end

function PinballTalentView:_createCostItem(obj, data, index)
	local num = gohelper.findChildTextMesh(obj, "#txt_num")
	local icon = gohelper.findChildImage(obj, "#txt_num/#image_icon")
	local resCo = lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][data.resType]

	if not resCo then
		logError("资源配置不存在" .. data.resType)

		return
	end

	UISpriteSetMgr.instance:setAct178Sprite(icon, resCo.icon)

	local color = ""

	if data.value > PinballModel.instance:getResNum(data.resType) then
		color = "<color=#FC8A6A>"
		self._costNoEnough = self._costNoEnough or resCo.name
	end

	num.text = string.format("%s-%d", color, data.value)
end

function PinballTalentView:_cancelSelect()
	gohelper.setActive(self._godetail, false)
	gohelper.setActive(self._gobtns, true)

	for _, talentItem in pairs(self._nodes) do
		talentItem:setSelect(false)
	end

	self._nowSelect = nil
end

function PinballTalentView:onClickModalMask()
	self:closeThis()
end

function PinballTalentView:_learnTalent()
	if not self._nowSelect or not self._selectData then
		return
	end

	local co = self._selectData.co
	local needLv = self._nowSelect._data.needLv
	local buildInfo = PinballModel.instance:getBuildingInfoById(co.id)

	if buildInfo and needLv > buildInfo.level then
		GameFacade.showToast(ToastEnum.Act178TalentLvNotEnough, co.name, needLv)

		return
	end

	if not self._nowSelect:canActive() then
		GameFacade.showToast(ToastEnum.Act178TalentCondition2)

		return
	end

	if self._costNoEnough then
		GameFacade.showToast(ToastEnum.DiamondBuy, self._costNoEnough)

		return
	end

	Activity178Rpc.instance:sendAct178UnlockTalent(VersionActivity2_4Enum.ActivityId.Pinball, self._nowSelect._data.id, self._onLearnTalent, self)
end

function PinballTalentView:_onLearnTalent(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	if not self._nowSelect then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio8)
	self._nowSelect:setSelect(false)
	self._nowSelect:onLearn()
	self:_refreshLineStatu()
	self:_cancelSelect()
end

return PinballTalentView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/summerdouble/SummerDoubleView.lua

module("logic.extensions.bonus.view.summerdouble.SummerDoubleView", package.seeall)

local SummerDoubleView = class("SummerDoubleView", ViewComponent)

function SummerDoubleView:ctor()
	SummerDoubleView.super.ctor(self)

	self._btnsItemList = nil
	self._comItemList = nil
	self._bigItemList = nil
end

function SummerDoubleView:bindEvents()
	SummerDoubleView.super.bindEvents(self)
	self._btnsItemList[1].itemBtn:AddClickListener(function()
		self:_onClickTableBtn(1)
	end, self)
	self._btnsItemList[2].itemBtn:AddClickListener(function()
		self:_onClickTableBtn(2)
	end, self)
	self._btnsItemList[3].itemBtn:AddClickListener(function()
		self:_onClickTableBtn(3)
	end, self)
	self._btnsItemList[4].itemBtn:AddClickListener(function()
		self:_onClickTableBtn(4)
	end, self)
end

function SummerDoubleView:unbindEvents()
	SummerDoubleView.super.unbindEvents(self)

	for _, item in pairs(self._btnsItemList or {}) do
		if item and item.itemBtn then
			item.itemBtn:RemoveClickListener()
		end
	end

	for _, item in pairs(self._comItemList or {}) do
		if item and item.itemGo then
			GameUtil.asBtn(item.itemGo):RemoveClickListener()
		end
	end

	for _, item in pairs(self._bigItemList or {}) do
		if item and item.itemGo then
			GameUtil.asBtn(item.itemGo):RemoveClickListener()
		end
	end
end

function SummerDoubleView:onExit()
	SummerDoubleView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_FORMULATASKRES, self._updataBtnItemRedpoint, self)

	for _, item in pairs(self._comItemList or {}) do
		if item and item.iconGo then
			uGuiUtil.clearImage(item.iconGo)
		end
	end

	for _, item in pairs(self._bigItemList or {}) do
		if item and item.iconGo then
			uGuiUtil.clearImage(item.iconGo)
		end
	end

	self._curClickIndex = nil
end

function SummerDoubleView:destroyUI()
	SummerDoubleView.super.destroyUI(self)

	for _, item in pairs(self._comItemList or {}) do
		if item and item.itemGo then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	for _, item in pairs(self._bigItemList or {}) do
		if item and item.itemGo then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self._btnsItemList = nil
	self._comItemList = nil
	self._bigItemList = nil
end

function SummerDoubleView:buildUI()
	SummerDoubleView.super.buildUI(self)

	local btnsTranGo = self:getGo("btnsTranGo")

	self._btnsItemList = {}

	local var_10_0 = {
		itemBtn = Framework.ButtonAdapter.GetFrom(btnsTranGo, "btnTab_1")
	}

	var_10_0.itemGrp = goutil.findChild(btnsTranGo, "btnTab_1"):GetComponent("UIChangeGroup")
	var_10_0.itemTxt = goutil.findChildTextComponent(btnsTranGo, "btnTab_1/btnTxt")
	self._btnsItemList[1] = var_10_0

	local var_10_1 = {
		itemBtn = Framework.ButtonAdapter.GetFrom(btnsTranGo, "btnTab_2")
	}

	var_10_1.itemGrp = goutil.findChild(btnsTranGo, "btnTab_2"):GetComponent("UIChangeGroup")
	var_10_1.itemTxt = goutil.findChildTextComponent(btnsTranGo, "btnTab_2/btnTxt")
	self._btnsItemList[2] = var_10_1

	local var_10_2 = {
		itemBtn = Framework.ButtonAdapter.GetFrom(btnsTranGo, "btnTab_3")
	}

	var_10_2.itemGrp = goutil.findChild(btnsTranGo, "btnTab_3"):GetComponent("UIChangeGroup")
	var_10_2.itemTxt = goutil.findChildTextComponent(btnsTranGo, "btnTab_3/btnTxt")
	var_10_2.btnRedGo = goutil.findChild(btnsTranGo, "btnTab_3/btnRedGo")
	self._btnsItemList[3] = var_10_2

	local var_10_3 = {
		itemBtn = Framework.ButtonAdapter.GetFrom(btnsTranGo, "btnTab_4")
	}

	var_10_3.itemGrp = goutil.findChild(btnsTranGo, "btnTab_4"):GetComponent("UIChangeGroup")
	var_10_3.itemTxt = goutil.findChildTextComponent(btnsTranGo, "btnTab_4/btnTxt")
	self._btnsItemList[4] = var_10_3
	self._timeTxt = self:getTxt("timeTxt")
	self._comCell = self:getGo("comCell")
	self._bigCell = self:getGo("bigCell")

	GameUtil.SetActive(self._bigCell, false)
	GameUtil.SetActive(self._comCell, false)
end

function SummerDoubleView:onEnter()
	SummerDoubleView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_FORMULATASKRES, self._updataBtnItemRedpoint, self)

	local value = GameUtil.getUserDayData("SummerDoubleRedpoint")

	if checknumber(value) ~= 1 then
		GameUtil.saveUserDayData("SummerDoubleRedpoint", 1)
		RedPointModel.instance:updateAllRedPoint()
	end

	RedPointController.instance:saveUserOnceRedPoint(RedPointModel.ID_SUMMERDOUBLE_FIRST_OPEN, true)
	self:_initAllCommonCell()
	self:_updataBtnItemRedpoint()
end

function SummerDoubleView:_updataBtnItemRedpoint()
	if self._btnsItemList and self._btnsItemList[3] and self._btnsItemList[3].btnRedGo then
		GameUtil.SetActive(self._btnsItemList[3].btnRedGo, RedPointModel.instance:isActiveByServer(417))
	end
end

function SummerDoubleView:_initAllCommonCell()
	self._curClickIndex = BounsModel.instance:getSummerDoubleTabIndex()

	local btnCfgs = PowerSurgeConfig.instance:getSummerDoubleTableCfgs()

	for i = 1, #self._btnsItemList do
		if btnCfgs and btnCfgs[i] then
			GameUtil.SetActive(self._btnsItemList[i].itemBtn, true)

			self._btnsItemList[i].itemTxt.text = btnCfgs[i].tabName

			local isInTime = GameUtil.checkIsInTimePeriod(btnCfgs[i].startTime, btnCfgs[i].endTime)

			if isInTime then
				self._curClickIndex = btnCfgs[i].tabId
			end
		else
			GameUtil.SetActive(self._btnsItemList[i].itemBtn, false)
		end

		self._btnsItemList[i].itemGrp:SetState(0)
	end

	self._comItemList = self._comItemList or {}
	self._bigItemList = self._bigItemList or {}

	self:_onClickTableBtn(self._curClickIndex, true)

	local timeStr = ""

	if self._curClickIndex > 0 then
		local data = btnCfgs[self._curClickIndex]

		if data then
			local startTime = GameUtil.string2date(data.startTime)
			local endTime = GameUtil.string2date(data.endTime)

			timeStr = langPara("本期时间：%02d.%02d %d:%02d-%02d.%02d %d:%02d", startTime.month, startTime.day, startTime.hour, startTime.min, endTime.month, endTime.day, endTime.hour, endTime.min)
		end
	end

	self._timeTxt.text = timeStr
end

function SummerDoubleView:_onClickTableBtn(tabId, isForce)
	if tabId <= 0 or checknumber(self._curClickIndex) == tabId and not isForce then
		return
	end

	local itemCfgs = PowerSurgeConfig.instance:getSummerDoubleItemCfgs(tabId)
	local btnCfg = PowerSurgeConfig.instance:getSummerDoubleTableCfgs(tabId)

	for _, item in pairs(self._comItemList or {}) do
		if item then
			if item.iconGo then
				uGuiUtil.clearImage(item.iconGo)
			end

			if item.itemGo then
				GameUtil.asBtn(item.itemGo):RemoveClickListener()
				GameUtil.SetActive(item.itemGo, false)
			end
		end
	end

	for _, item in pairs(self._bigItemList or {}) do
		if item then
			if item.iconGo then
				uGuiUtil.clearImage(item.iconGo)
			end

			if item.itemGo then
				GameUtil.asBtn(item.itemGo):RemoveClickListener()
				GameUtil.SetActive(item.itemGo, false)
			end
		end
	end

	local path = "ui/bigbg/summerdouble/%s.png"

	for i = 1, #itemCfgs do
		if itemCfgs[i] and not string.nilorempty(itemCfgs[i].name) then
			if itemCfgs[i].isBigItem then
				if not self._bigItemList[i] then
					local item = self._comItemList[i]

					if item == nil or item.itemGo == nil then
						item = {}

						if itemCfgs[i].isBigItem then
							if not self._bigCell then
								do
									local cell = self._comCell
									local go = UnityEngine.GameObject.Instantiate(cell, self.mainGO.transform)

									item.itemGo = go
									item.iconGo = goutil.findChild(go, "iconIma")
									item.nameTxt = goutil.findChildTextComponent(go, "nameGo/nameTxt")
									item.tagGo = goutil.findChild(go, "tagGo")
									item.tagTxt = goutil.findChildTextComponent(go, "tagGo/tagTxt")
									item.redPoint = goutil.findChild(go, "redpoint")
								end

								if item.redPoint then
									local isNeedRed = false

									if self:_isCurrentItemOpen(tabId, true) then
										local tabName = btnCfg.tabName

										isNeedRed = GameUtil.getUserData("SummerDoubleRedpoint_tab_" .. tabId .. "_" .. tabName .. "_btn_" .. i) ~= 1
									end

									GameUtil.SetActive(item.redPoint, isNeedRed)
								end
							end
						end
					end

					GameUtil.SetActive(item.itemGo, true)
					Framework.TransformUtil.SetLocalPos(item.itemGo.transform, itemCfgs[i].pos[1], itemCfgs[i].pos[2], 0)
					uGuiUtil.setSpriteToImage(item.iconGo, uGuiUtil.SpriteType.BigBg, string.format(path, itemCfgs[i].iconpath))

					item.nameTxt.text = itemCfgs[i].name

					if string.nilorempty(itemCfgs[i].tag) then
						GameUtil.SetActive(item.tagGo, false)
					else
						GameUtil.SetActive(item.tagGo, true)

						self._comItemList[i].tagTxt = itemCfgs[i].tag
					end

					if not string.nilorempty(itemCfgs[i].jumpTo) then
						GameUtil.asBtn(item.itemGo):AddClickListener(function()
							if not self:_isCurrentItemOpen(self._curClickIndex, true) then
								return
							end

							local tabName = btnCfg.tabName

							GameUtil.saveUserData("SummerDoubleRedpoint_tab_" .. self._curClickIndex .. "_" .. tabName .. "_btn_" .. i, 1)
							self:_updataBtnItemRedpoint()
							GotoMgr.gotoByString(itemCfgs[i].jumpTo)
						end, self)
					end

					if itemCfgs[i].isBigItem then
						self._bigItemList[i] = item
					else
						self._comItemList[i] = item
					end
				end
			end
		end
	end

	self._curClickIndex = tabId

	BounsModel.instance:setSummerDoubleTabIndex(self._curClickIndex)

	for i = 1, #self._btnsItemList do
		if self._btnsItemList[i] and self._btnsItemList[i].itemGrp then
			if i == tabId then
				self._btnsItemList[i].itemGrp:SetState(1)
			else
				self._btnsItemList[i].itemGrp:SetState(0)
			end
		end
	end
end

function SummerDoubleView:_isCurrentItemOpen(index, isTips)
	local btnCfg = PowerSurgeConfig.instance:getSummerDoubleTableCfgs(index)

	if btnCfg == nil then
		if isTips then
			FloatWordMgr.instance:show("目前不在活动时间内哦~")
		end

		return false
	end

	if string.nilorempty(btnCfg.startTime) or string.nilorempty(btnCfg.endTime) then
		return true
	end

	if GameUtil.checkIsInTimePeriod(btnCfg.startTime, btnCfg.endTime) then
		return true
	end

	if isTips then
		FloatWordMgr.instance:show("目前不在活动时间内哦~")
	end

	return false
end

return SummerDoubleView

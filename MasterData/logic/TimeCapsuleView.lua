-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timecapsule/view/TimeCapsuleView.lua

module("logic.extensions.timecapsule.view.TimeCapsuleView", package.seeall)

local TimeCapsuleView = class("TimeCapsuleView", ViewComponent)

function TimeCapsuleView:ctor()
	TimeCapsuleView.super.ctor(self)
end

function TimeCapsuleView:buildUI()
	TimeCapsuleView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._time = goutil.findChildTextComponent(self.mainGO, "time")
	self._tipBtn = self:getBtn("tipBtn")
	self._searchBtn = self:getBtn("searchBtn")
	self._treasureMap = self:getGo("treasureMap")
	self._treasureMapBtn = self:getBtn("treasureMap/btn")
	self._treasureMapRed = self:getGo("treasureMap/red")
	self._goDigBtn = self:getBtn("goDigBtn")
	self._leftBtn = self:getBtn("leftBtn")
	self._leftRed = self:getGo("leftBtn/red")
	self._rightBtn = self:getBtn("rightBtn")
	self._rightRed = self:getGo("rightBtn/red")
	self._note = self:getGo("note")
	self._points = {
		root = self:getGo("noteBoard")
	}

	for i = 1, 15 do
		self._points[i] = self:getGo("noteBoard/point_" .. i .. "/dot")
	end

	self._emptyText = self:getGo("emptyText")
	self._prizeView = self:getGo("prizeView")
	self._prizes = {}

	for i = 1, 9 do
		self._prizes[i] = self:getGo("prizeView/Viewport/Content/prizes/prize_" .. i)
	end

	self._progress = self:getSlider("prizeView/Viewport/Content/progress")
	self._progressText = goutil.findChildTextComponent(self.mainGO, "progressNum")
end

function TimeCapsuleView:bindEvents()
	TimeCapsuleView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._leftBtn:AddClickListener(self._onClickLeft, self)
	self._rightBtn:AddClickListener(self._onClickRight, self)
	self._goDigBtn:AddClickListener(self._onClickGo, self)
	self._tipBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "timeCapsule")
	end)
	self._searchBtn:AddClickListener(function()
		self:_treasureMapEffStatus(false)
		UIStateManager.instance:push(ViewName.SearchNoteView, function()
			self:_treasureMapEffStatus(true)
		end)
	end)
end

function TimeCapsuleView:unbindEvents()
	TimeCapsuleView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._leftBtn:RemoveClickListener()
	self._rightBtn:RemoveClickListener()
	self._treasureMapBtn:RemoveClickListener()
	self._goDigBtn:RemoveClickListener()
	self._searchBtn:RemoveClickListener()
end

function TimeCapsuleView:destroyUI()
	TimeCapsuleView.super.destroyUI(self)
end

function TimeCapsuleView:onEnter()
	TimeCapsuleView.super.onEnter(self)

	self._noteList = {}

	local prizeInfo = TimeCapsuleConfig.instance:getProgressPrize()

	self._time.text = TimeCapsuleController.instance:getActivityTime()

	MaterialMgr.setCellByCfg(TimeCapsuleConfig.instance:getCommonValue("DAILY_REWARD"), self._treasureMap)
	self._treasureMapBtn.transform:SetAsLastSibling()

	local startTime = GameUtil.string2time(TimeCapsuleConfig.instance:getCommonValue("ACT_START_TIME"))
	local endTime = GameUtil.string2time(TimeCapsuleConfig.instance:getCommonValue("ACT_END_TIME"))

	self._updateGray = {}
	self._updateScale = {}

	FixedUpdateBeat:Add(self._animation, self)

	if startTime > ServerTime.now() or endTime < ServerTime.now() then
		local startTable, endTable = GameUtil.time2date(startTime), GameUtil.time2date(endTime)

		FloatWordMgr.instance:show(string.format("活动开启时间为：%d月%d日%d:%02d-%d月%d日%d:%02d，当前不在开启时间内", startTable.month, startTable.day, startTable.hour, startTable.min, endTable.month, endTable.day, endTable.hour, endTable.min))

		return
	end

	self._isView = true
	self._page = 1

	TimeCapsuleAgent.instance:sendPM_TCGetInfoReq(function(msg)
		if not self._isView then
			return
		end

		TimeCapsuleModel.instance:setNoteInfo(msg.notes)
		TimeCapsuleModel.instance:setGainDailyPrizeBit(msg.gainDailyPrizeBit)

		local noteNum = TimeCapsuleModel.instance:getNoteNum()

		self._progress:SetValue(noteNum)

		self._progressText.text = noteNum

		if msg.gainDailyPrizeBit then
			goutil.setActive(self._treasureMapBtn.gameObject, false)
			goutil.setActive(self._treasureMapRed, false)

			local received = goutil.findChild(self._treasureMap, "received")

			goutil.setActive(received, true)
			received.transform:SetAsLastSibling()
		else
			local effResPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

			self._treasureMapEff = UIEffectManager.instance:playEffect(self, effResPath, nil, 0, 0, true, false, nil, function(target, eff)
				eff.effGo.transform:SetParent(self._treasureMap.transform)
				GameUtil.setAnchoredPos(eff.effGo, 1.6, 2.2)
				GameUtil.setLocalScale(eff.effGo, 0.95, 0.95, 1)
				eff:setClipping(self._treasureMap:GetComponent(goutil.Type_RectTransform))

				if not msg.everOpenFunc then
					self:_treasureMapEffStatus(false)
					UIStateManager.instance:push(ViewName.TimedialogueView, function()
						self:_treasureMapEffStatus(true)
					end)
				end
			end)
			self._treasureMapEff.hideEffWhileNotOnTop = false

			self._treasureMapBtn:AddClickListener(self._onClickMap, self)
			goutil.setActive(self._treasureMapBtn.gameObject, true)
			goutil.setActive(self._treasureMapRed, true)
			self._treasureMapRed.transform:SetAsLastSibling()
		end

		self:_loadPageInfo(1)

		if noteNum > 0 then
			goutil.setActive(self._emptyText, false)
		else
			goutil.setActive(self._points.root, false)
			goutil.setActive(self._emptyText, true)
		end

		for i, v in ipairs(self._prizes) do
			goutil.findChildTextComponent(v, "needNum").text = prizeInfo[i].leftProgress

			local arr = MaterialMgr.changeItemStrArr(prizeInfo[i].reward)
			local proxy = MaterialMgr.setCellByCfg(arr[1], v)

			Framework.TransformUtil.SetLocalScale(proxy.view.transform, 0.6, 0.6, 1)

			if noteNum < prizeInfo[i].leftProgress then
				goutil.findChildComponent(v, "satisfyIma", "UIChangeGroup"):SetState(0)
			elseif msg.gainProgressPrizeBit[i] then
				goutil.findChildComponent(v, "satisfyIma", "UIChangeGroup"):SetState(1)

				local receiveShowGo = goutil.findChild(v, "receiveShowGo")

				goutil.setActive(receiveShowGo, true)
				receiveShowGo.transform:SetAsLastSibling()
			else
				goutil.findChildComponent(v, "satisfyIma", "UIChangeGroup"):SetState(1)

				local itemBtn = Framework.ButtonAdapter.GetFrom(v, "itemBtn")

				goutil.setActive(itemBtn.gameObject, true)
				itemBtn.transform:SetAsLastSibling()

				local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
				local eff = UIEffectManager.instance:playEffect(self, effPath, nil, 0, 0, true, nil, nil, function(p_self, uiEff)
					uiEff:setParent(v.transform)
					Framework.TransformUtil.SetLocalPos(uiEff.effGo.transform, 0, 0, 0)
					uiEff:setScale(0.6)
					uiEff:setClipping(self._prizeView:GetComponent(goutil.Type_RectTransform))
				end)

				itemBtn:AddClickListener(function()
					TimeCapsuleAgent.instance:sendPM_TCGainProgressPrizeReq(prizeInfo[i].id, function()
						local receiveShowGo = goutil.findChild(v, "receiveShowGo")

						goutil.setActive(receiveShowGo, true)
						receiveShowGo.transform:SetAsLastSibling()
						goutil.setActive(itemBtn.gameObject, false)
						itemBtn:RemoveClickListener()
						UIEffectManager.instance:stopEffect(eff)
					end)
				end)
			end
		end
	end)
end

function TimeCapsuleView:onEnterFinished()
	TimeCapsuleView.super.onEnterFinished(self)
end

function TimeCapsuleView:onExit()
	TimeCapsuleView.super.onExit(self)

	self._isView = false

	FixedUpdateBeat:Remove(self._animation, self)

	for k, value in pairs(self._noteList) do
		goutil.destroy(value)
	end

	local noteActiveList = TimeCapsuleModel.instance:getNoteActiveList()

	if #noteActiveList > 0 then
		TimeCapsuleAgent.instance:sendPM_TCActivateNotesReq(noteActiveList, function()
			TimeCapsuleModel.instance:clearNoteActiveList()
		end)
	end

	for i, v in ipairs(self._prizes) do
		MaterialMgr.resetAll(v)
	end

	MaterialMgr.resetAll(self._treasureMap)
	UIEffectManager.instance:stopEffect(self._treasureMapEff)

	self._treasureMapEff = nil

	GlobalModel.instance:visibleMainCamera(true)
end

function TimeCapsuleView:onExitFinished()
	TimeCapsuleView.super.onExitFinished(self)
end

function TimeCapsuleView:_loadPageInfo(page)
	for k, v in pairs(self._noteList) do
		goutil.setActive(v, false)
	end

	local noteInfos = TimeCapsuleModel.instance:getNoteInfoByPage(page)

	for i, v in ipairs(self._points) do
		if noteInfos[i] then
			if not self._noteList[i] then
				local clone = goutil.cloneAndSetParent(self._note, self._points[i].transform)

				goutil.setActive(goutil.findChild(clone, "red"), not noteInfos[i].active)

				local angle = math.random(-5, 5)

				clone:GetComponent(goutil.Type_RectTransform).rotation = Quaternion:SetEuler(0, 0, angle)

				local grayBtn = Framework.ButtonAdapter.GetFrom(clone, "grayBtn")

				goutil.findChild(grayBtn, "lock"):GetComponent(goutil.Type_RectTransform).rotation = Quaternion:SetEuler(0, 0, -angle)

				goutil.setActive(grayBtn.gameObject, not noteInfos[i].active)

				goutil.findChildTextComponent(clone, "title").text = noteInfos[i].title

				goutil.findChildComponent(clone, "noteImg", "UIImageSpriteChange"):SetState(noteInfos[i].icon)

				if not noteInfos[i].active then
					GameUtil.setLocalScale(clone, 3, 3, 1)
					table.insert(self._updateScale, {
						speed = 0.06,
						scale = 3,
						go = clone
					})

					clone:GetComponent(goutil.Type_UIImage).material = UnityEngine.GameObject.Instantiate(CommonPreloader.instance:getSkinlibAsset(CommonResPath.GrayTransitionMat))

					local imgMaterial = clone:GetComponent(goutil.Type_UIImage).material

					imgMaterial:SetFloat("_GrayValue", 1)
					grayBtn:AddClickListener(function()
						table.insert(self._updateGray, {
							grayValue = 1,
							speed = 0.04,
							material = imgMaterial
						})
						grayBtn:RemoveClickListener()
						goutil.setActive(grayBtn.gameObject, false)
						goutil.setActive(goutil.findChild(clone, "red"), false)

						goutil.findChildTextComponent(clone, "title").text = noteInfos[i].title

						TimeCapsuleModel.instance:setNoteActive(noteInfos[i].noteId)
					end)

					goutil.findChildTextComponent(clone, "title").text = "未解锁"
				end

				local imgMaterial = clone:GetComponent(goutil.Type_UIImage).material

				if imgMaterial and noteInfos[i].active then
					imgMaterial:SetFloat("_GrayValue", 0)
				end

				clone.transform:SetAsFirstSibling()
				GameUtil.setAnchoredPos(clone, 0, 0)
				goutil.setActive(clone, true)
				Framework.ButtonAdapter.GetFrom(clone, "openBtn"):AddClickListener(function()
					if self._treasureMapEff then
						UIEffectManager.instance:stopEffect(self._treasureMapEff)

						self._treasureMapEff = "playEff"
					end

					UIStateManager.instance:push(ViewName.NoteView, noteInfos[i].noteId, function()
						if self._treasureMapEff == "playEff" then
							local effResPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

							self._treasureMapEff = UIEffectManager.instance:playEffect(self, effResPath, nil, 0, 0, true, false, nil, function(target, eff)
								eff.effGo.transform:SetParent(self._treasureMap.transform)
								GameUtil.setAnchoredPos(eff.effGo, 1.6, 2.2)
								GameUtil.setLocalScale(eff.effGo, 0.95, 0.95, 1)
								eff:setClipping(self._treasureMap:GetComponent(goutil.Type_RectTransform))
							end)
						end
					end)
				end)

				self._noteList[i] = clone
			end
		elseif self._noteList[i] then
			goutil.destroy(self._noteList[i])

			self._noteList[i] = nil
		end
	end

	goutil.setActive(self._leftBtn.gameObject, page > 1)
	goutil.setActive(self._leftRed, TimeCapsuleController.instance:pageRed(page - 1))
	goutil.setActive(self._rightBtn.gameObject, page < TimeCapsuleModel.instance:getMaxPageNum())
	goutil.setActive(self._rightRed, TimeCapsuleController.instance:pageRed(page + 1))
end

function TimeCapsuleView:_animation()
	if #self._updateGray > 0 then
		for i = #self._updateGray, 1, -1 do
			if self._updateGray[i].grayValue > 0 then
				self._updateGray[i].grayValue = self._updateGray[i].grayValue - self._updateGray[i].speed

				self._updateGray[i].material:SetFloat("_GrayValue", self._updateGray[i].grayValue)
			else
				self._updateGray[i].material:SetFloat("_GrayValue", 0)
				table.remove(self._updateGray, i)
			end
		end
	end

	if #self._updateScale > 0 then
		for i = #self._updateScale, 1, -1 do
			if self._updateScale[i].scale > 1 then
				self._updateScale[i].scale = self._updateScale[i].scale - self._updateScale[i].speed

				GameUtil.setLocalScale(self._updateScale[i].go, self._updateScale[i].scale, self._updateScale[i].scale, 1)
			else
				GameUtil.setLocalScale(self._updateScale[i].go, 1, 1, 1)
				table.remove(self._updateScale, i)
			end
		end
	end
end

function TimeCapsuleView:_treasureMapEffStatus(flag)
	if self._treasureMapEff then
		goutil.setActive(self._treasureMapEff.effGo, flag)
	end
end

function TimeCapsuleView:_onClickLeft()
	if self._page > 1 then
		self._page = self._page - 1

		self:_loadPageInfo(self._page)
	end
end

function TimeCapsuleView:_onClickRight()
	if self._page < TimeCapsuleModel.instance:getMaxPageNum() then
		self._page = self._page + 1

		self:_loadPageInfo(self._page)
	end
end

function TimeCapsuleView:_onClickMap()
	TimeCapsuleAgent.instance:sendPM_TCGainDailyPrizeReq(function()
		TimeCapsuleModel.instance:setGainDailyPrizeBit(true)
		UIEffectManager.instance:stopEffect(self._treasureMapEff)
		self._treasureMapBtn:RemoveClickListener()
		goutil.setActive(self._treasureMapBtn.gameObject, false)
		goutil.setActive(self._treasureMapRed, false)

		local received = goutil.findChild(self._treasureMap, "received")

		goutil.setActive(received, true)
		received.transform:SetAsLastSibling()
	end)
end

function TimeCapsuleView:_onClickGo()
	if EscortModel.instance:IsPickupEscort() then
		FloatWordMgr.instance:show("护送时不可进行挖宝！")

		return
	end

	local TreasureMap, HighTreasureMap = MaterialMgr.getModel(MatType.Item, 601), MaterialMgr.getModel(MatType.Item, 602)

	local function callBack()
		self:close()
		MaterialFacade.instance:useItem(MatType.Item, 601, 1, TreasureNewController.instance:getlockCSceneListJson(), UIStateManager.instance:clear())
	end

	local function callBack2()
		self:close()
		MaterialFacade.instance:useItem(MatType.Item, 602, 1, TreasureNewController.instance:getlockCSceneListJson(), UIStateManager.instance:clear())
	end

	if TreasureMap or HighTreasureMap then
		if TimeCapsuleModel.instance:getNoteNum() < tonumber(TimeCapsuleConfig.instance:getCommonValue("MAX_COLLECT_COUNT")) then
			if TreasureMap then
				TipsFacade.instance:openTipWindow("提示", TimeCapsuleConfig.instance:getCommonValue("DIG_TIP"), callBack)
			else
				TipsFacade.instance:openTipWindow("提示", string.gsub(TimeCapsuleConfig.instance:getCommonValue("DIG_TIP"), "藏宝图", "高级藏宝图"), callBack2)
			end
		elseif TreasureMap then
			TipsFacade.instance:openTipWindow("提示", TimeCapsuleConfig.instance:getCommonValue("DIG_TIP_MAX"), callBack)
		else
			TipsFacade.instance:openTipWindow("提示", string.gsub(TimeCapsuleConfig.instance:getCommonValue("DIG_TIP_MAX"), "藏宝图", "高级藏宝图"), callBack2)
		end
	else
		FloatWordMgr.instance:show(TimeCapsuleConfig.instance:getCommonValue("NONE_DIG"))
		MaterialMgr.openGetSource(MatType.Item, 601)
	end
end

return TimeCapsuleView

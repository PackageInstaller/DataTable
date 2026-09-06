-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yunuotongxing/view/YunuotongxingpuzzleView.lua

module("logic.extensions.yunuotongxing.view.YunuotongxingpuzzleView", package.seeall)

local YunuotongxingpuzzleView = class("YunuotongxingpuzzleView", ViewComponent)

function YunuotongxingpuzzleView:buildUI()
	YunuotongxingpuzzleView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnGet = self:getGo("btnGet")
	self._btnJump = self:getGo("btnJump")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._redpoint = self:getGo("btnGet/redpoint")
	self._txtTime = self:getTxt("txtTime/txt")
	self._txtEmpty = self:getTxt("empty/txtEmpty")
	self._redpointJump = self:getGo("btnJump/redpoint")
	self._btnRank = self:getGo("btnRank")
	self._basePicture = self:getGo("basePicture")
	self._picture = self:getGo("picture")
	self._chip = self:getGo("chip")
	self._chipCell = self:getGo("chipCell")
	self._scrollrect = goutil.findChildComponent(self.mainGO, "chipView", typeof(UnityEngine.UI.ScrollRect))
	self._chipView = ScrollerList.create(self:getGo("chipView"), self._chipCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._empty = self:getGo("empty")

	self._chipView:setDragCallBack("top", GameUtil.handler(self._OnBeginDragSeat, self), GameUtil.handler(self._OnDragSeat, self), GameUtil.handler(self._OnEndDragSeat, self))

	self._btnWorld = self:getGo("worldRectTrans/root/btn")
	self._btnWorldRp = self:getGo("worldRectTrans/root/btn/redpoint")
	self._arrowWorld = self:getGo("worldRectTrans/root/btn/arrow")
	self._worldRoot = self:getGo("worldRectTrans/root")
	self._worldMask = self:getGo("worldMask")
	self._worldContent = self:getGo("worldRectTrans/root/content")
	self._worldProgText = self:getGo("worldRectTrans/root/content/progress/prog"):GetComponent(typeof(UnityEngine.UI.Text))
	self._worldProgBar = self:getGo("worldRectTrans/root/content/tableview/viewport/content/progBar"):GetComponent("Slider")
	self._worldCell = self:getGo("worldRectTrans/root/content/tableview/cell")
	self._worldTableview = self:getGo("worldRectTrans/root/content/tableview")
	self._worldRectTrans = self:getGo("worldRectTrans"):GetComponent(typeof(UnityEngine.RectTransform))
	self._worldSl = ScrollerList.create(self._worldTableview, self._worldCell, GameUtil.handler(self._updateWorldSlCell, self), GameUtil.handler(self._clearWorldSlCell, self))
end

function YunuotongxingpuzzleView:bindEvents()
	YunuotongxingpuzzleView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnWorld, self._onClickBtnWorld, self)
	GameUtil.addClickHandler(self._worldMask, self._onClickBtnWorld, self)
	GameUtil.addClickHandler(self._btnGet, self._onClickGet, self)
	GameUtil.addClickHandler(self._btnJump, self._onClickJump, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnRank, self._openRankView, self)
end

function YunuotongxingpuzzleView:unbindEvents()
	YunuotongxingpuzzleView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnWorld)
	GameUtil.rmClickHandler(self._worldMask)
	GameUtil.rmClickHandler(self._btnGet)
	GameUtil.rmClickHandler(self._btnJump)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
end

function YunuotongxingpuzzleView:onExit()
	YunuotongxingpuzzleView.super.onExit(self)
	FixedUpdateBeat:Remove(self._trueAnimation, self)
	FixedUpdateBeat:Remove(self._falseAnimation, self)
	uGuiUtil.clearImage(self._basePicture)
	self._chipView:dispose()
	UIEffectManager.instance:stopEffect(self._viewEff)
	self._worldSl:dispose()
	RedPointController.instance:unregRedPoint(self._redpoint)
	RedPointController.instance:unregRedPoint(self._redpointJump)
end

function YunuotongxingpuzzleView:onExitFinished()
	YunuotongxingpuzzleView.super.onExitFinished(self)

	for i, v in ipairs(self._chips) do
		goutil.destroy(v)
	end

	for i, v in ipairs(self._effList) do
		UIEffectManager.instance:stopEffect(v)
	end

	if self._worldEffectMap then
		for _, effect in pairs(self._worldEffectMap) do
			self:_unloadEffect(effect)
		end

		self._worldEffectMap = nil
	end
end

function YunuotongxingpuzzleView:onEnter()
	YunuotongxingpuzzleView.super.onEnter(self)

	self._offestX = 0
	self._offestY = 0
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = YuNuoTongXingController.instance:getActivityId()
	end

	self:_onInitUI()

	self._worldEffectMap = {}

	self.addGEvent(self, GlobalNotify.PM_IF_FORMULATASKRES, self._onSendGetInfo, self)
	self.addGEvent(self, GlobalNotify.YUNUOTONGXING_INFO_UPDATE, self._onRefreshUI, self)
	self:_onSendGetInfo()
	self:_onRefreshUI()

	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function YunuotongxingpuzzleView:_onSendGetInfo()
	YuNuoTongXingController.instance:sendGetInfo(self._activityId)
end

function YunuotongxingpuzzleView:_onInitUI()
	local actCfg = YuNuoTongXingConfig.instance:getActiveCfgById(self._activityId) or {}

	self._chipList = YuNuoTongXingConfig.instance:getPiecePlanCfgs(self._activityId) or {}
	self._chips = {}

	for i, data in ipairs(self._chipList) do
		self._chips[i] = goutil.cloneAndSetParent(self._chip, self._picture.transform, "chip_" .. i)

		goutil.setActive(self._chips[i], true)

		local go = goutil.findChild(self._chips[i], "Image")

		uGuiUtil.setSpriteToImage(go, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("picturepuzzle", data.icon))
		goutil.setActive(go, false)
	end

	uGuiUtil.setSpriteToImage(self._basePicture, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgPngUrl("picturepuzzle/" .. actCfg.baseIcon))

	self._isShowWorld = false

	self:_closeWorldSl(self._offestX, self._offestY)
end

function YunuotongxingpuzzleView:_onRefreshUI()
	local actCfg = YuNuoTongXingConfig.instance:getActiveCfgById(self._activityId) or {}
	local info = YuNuoTongXingModel.instance:getInfo(self._activityId) or {}

	self._placePieceIds = info.placePieceIds or {}
	self._gainPieceIds = info.gainPieceIds or {}
	self._gainProgressPrizeIds = info.gainProgressPrizeIds or {}

	for i, cell in ipairs(self._chips) do
		local has = table.indexof(self._placePieceIds, i) ~= false

		uGuiUtil.setGoGrayState(cell, not has)

		local img = goutil.findChild(cell, "Image")

		goutil.setActive(img, has)
	end

	local map = {}

	for i, v in ipairs(self._placePieceIds) do
		map[v] = true
	end

	local gainMap = {}

	for i, v in ipairs(self._gainPieceIds) do
		gainMap[v] = true
	end

	local list = {}
	local randomPieceIds = YuNuoTongXingModel.instance:getRandomPieceIds(self._activityId)

	for i, v in ipairs(randomPieceIds) do
		if gainMap[v] and not map[v] then
			table.insert(list, v)
		end
	end

	self._chipView:reloadData(list)
	GameUtil.SetActive(self._empty, #list == 0)

	self._txtEmpty.text = "还没有碎片，快去收集吧"

	if #self._placePieceIds == checknumber(actCfg.pieceCount) then
		self._txtEmpty.text = "拼图已完成"
	end

	self._effList = {}

	local list = YuNuoTongXingConfig.instance:getPrizeCfgs(self._activityId) or {}

	self._worldSl:reloadData(list)

	self._worldProg = self:_setSliderValue(self._worldProgBar, self._worldProgText, list, #self._placePieceIds)

	self._worldSl:MoveCellToCenter(self._worldProg)

	local arr = string.split(actCfg.taskJump, "#")
	local taskActId = checknumber(arr[#arr])
	local rd = false

	GameUtil.SetActive(self._redpoint, rd)

	if taskActId > 0 then
		local taskRedId = EventTaskSummaryController.instance:getCurRedIdByActivityId(taskActId)

		if taskRedId > 0 then
			RedPointController.instance:regRedPoint(self._redpoint, taskRedId)
		end
	end

	RedPointController.instance:regRedPoint(self._redpointJump, 213)
end

function YunuotongxingpuzzleView:_setSliderValue(progBar, progText, cfgList, progress)
	local curProgStep = 1
	local curValue = 0

	progress = checknumber(progress) and progress or 0

	if progText then
		progText.text = "<color=#F8D200FF>" .. tostring(progress) .. "</color>次"
	end

	goutil.setActive(self._btnWorldRp, false)

	if progBar then
		local perValue = 1 / #cfgList
		local isTooBigger = progress > 0

		for i, v in ipairs(cfgList) do
			if i - 1 > 0 then
				if not cfgList[i - 1].progress then
					local preStep = 0
					local nextStep = cfgList[i].progress

					if nextStep <= progress and table.keyof(self._gainProgressPrizeIds, v.prizeId) == nil then
						goutil.setActive(self._btnWorldRp, true)
					end

					if preStep < progress and progress <= nextStep then
						local baseValue = perValue * (i - 1)

						curValue = baseValue + (progress - preStep) / (nextStep - preStep) * perValue
						curProgStep = i
						isTooBigger = false

						break
					end
				end
			end
		end

		curValue = isTooBigger and 1 or curValue
		curProgStep = isTooBigger and #cfgList or curProgStep
		progBar.value = curValue
	end

	return curProgStep
end

function YunuotongxingpuzzleView:_onClickGet()
	local actCfg = YuNuoTongXingConfig.instance:getActiveCfgById(self._activityId) or {}

	GotoMgr.gotoByString(actCfg.taskJump)
end

function YunuotongxingpuzzleView:_onClickJump()
	GotoMgr.gotoByString("func#1043")
end

function YunuotongxingpuzzleView:_onClickTip()
	TipsFacade.instance:openRulesView("yunuotongxingpuzzleview_rule")
end

function YunuotongxingpuzzleView:_onClickBtnWorld()
	if self._isShowWorld then
		self._isShowWorld = false

		self:_closeWorldSl(self._offestX, self._offestY)
	else
		self._isShowWorld = true

		self:_openWorldSl(self._offestX, self._offestY)
	end
end

function YunuotongxingpuzzleView:_openWorldSl(offestX, offestY)
	GameUtil.SetActive(self._worldContent, true)
	GameUtil.SetActive(self._worldMask, true)
	GameUtil.setAnchoredPos(self._worldRoot, -2.46 + offestX, -267.3 + offestY)
	GameUtil.setLocalRotation(self._arrowWorld, 0, 0, 0)
end

function YunuotongxingpuzzleView:_closeWorldSl(offestX, offestY)
	GameUtil.SetActive(self._worldContent, false)
	GameUtil.SetActive(self._worldMask, false)
	GameUtil.setAnchoredPos(self._worldRoot, 184.2 + offestX, -267.3 + offestY)
	GameUtil.setLocalRotation(self._arrowWorld, 0, 0, 180)
end

function YunuotongxingpuzzleView:_updateWorldSlCell(view, cell, data)
	self:_clearWorldSlCell(cell)

	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")
	local got = goutil.findChild(cell, "got")
	local progress = goutil.findChildTextComponent(cell, "progress")
	local prizes = string.split(data.prize, "#")
	local proxy = MaterialMgr.setCellByCfg(prizes[1], item)
	local gainWorldPrizeIds = self._gainProgressPrizeIds
	local isGot = table.keyof(gainWorldPrizeIds, data.prizeId) or false
	local canGet = not isGot and data.progress <= #self._placePieceIds
	local btn = goutil.findChild(cell, "btn")

	if canGet then
		self._worldEffectMap[cell] = self:_loadEffect(effect, self._worldRectTrans)

		GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickBtnPrize, self, data.prizeId))
	end

	progress.text = tostring(data.progress)

	goutil.setActive(got, isGot)
	goutil.setActive(btn, canGet)
end

function YunuotongxingpuzzleView:_loadEffect(root, rectTrans)
	local effectPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local effect

	effect = UIEffectManager.instance:playEffect(self, effectPath, root.transform, 0, 0, true, false, nil, function()
		if rectTrans then
			effect:setClipping(rectTrans)
		end
	end)

	effect:setParent(root.transform)
	effect:setScale(1)
	effect:setLocalPos(0, 0, 0)

	return effect
end

function YunuotongxingpuzzleView:_unloadEffect(effect)
	if effect then
		UIEffectManager.instance:stopEffect(effect)

		effect = nil
	end
end

function YunuotongxingpuzzleView:_onClickBtnPrize(prizeId)
	YuNuoTongXingController.instance:sendGetPrize(self._activityId, prizeId)
end

function YunuotongxingpuzzleView:_clearWorldSlCell(cell)
	local btn = goutil.findChild(cell, "btn")
	local got = goutil.findChild(cell, "got")
	local item = goutil.findChild(cell, "item")

	goutil.setActive(got, false)

	if self._worldEffectMap and self._worldEffectMap[cell] then
		self:_unloadEffect(self._worldEffectMap[cell])
	end

	GameUtil.rmClickHandler(btn)
	goutil.setActive(btn, false)
	MaterialMgr.resetAll(item)
end

function YunuotongxingpuzzleView:_updateCell(view, cell, data)
	local con = goutil.findChild(cell, "con")
	local cfg = YuNuoTongXingConfig.instance:getPieceCfgById(self._activityId, data)

	uGuiUtil.setSpriteToImage(con.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("picturepuzzle", cfg.icon))
end

function YunuotongxingpuzzleView:_clearCell(cell)
	local con = goutil.findChild(cell, "con")

	uGuiUtil.clearImage(con.gameObject)
end

function YunuotongxingpuzzleView:_OnBeginDragSeat(eventData, data)
	local drag = math.abs(eventData.delta.y) > math.abs(eventData.delta.x)

	if drag and not self._dragFlag then
		self._dragFlag = true
		self._dragGo = goutil.cloneAndSetParent(self._chip, self.mainGO.transform)

		goutil.setActive(self._dragGo, true)

		local iconGo = goutil.findChild(self._dragGo, "Image")
		local cfg = YuNuoTongXingConfig.instance:getPieceCfgById(self._activityId, data)
		local icon = cfg.icon

		uGuiUtil.setSpriteToImage(iconGo, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("picturepuzzle", icon))

		self._dragGo.transform.position = uGuiUtil.GetTouchWorldPosition()

		local x, y = Framework.TransformUtil.GetAnchoredPos(self._dragGo:GetComponent(goutil.Type_RectTransform), 0, 0)

		self._animParam = {
			animTime = 0,
			beginVec = Vector2.New(x, y)
		}
	end
end

function YunuotongxingpuzzleView:_OnEndDragSeat(eventData, data)
	if self._dragFlag then
		local id, target = data, self._chips[data]
		local x, y = Framework.TransformUtil.GetAnchoredPos(self._dragGo:GetComponent(goutil.Type_RectTransform), 0, 0)
		local tarX, tarY = Framework.TransformUtil.GetAnchoredPos(target:GetComponent(goutil.Type_RectTransform), 0, 0)
		local x1, y1 = Framework.TransformUtil.GetAnchoredPos(self._picture:GetComponent(goutil.Type_RectTransform), 0, 0)
		local width, height = goutil.getWidth(self._picture:GetComponent(goutil.Type_RectTransform)), goutil.getHeight(self._picture:GetComponent(goutil.Type_RectTransform))

		tarX = tarX - width / 2 + x1
		tarY = tarY + height / 2 + y1

		if (x - tarX)^2 + (y - tarY)^2 < 2500 then
			self._animParam.tarId = id
			self._animParam.tarGo = self._chips[id]
			self._animParam.endVec = Vector2.New(tarX, tarY)
			self._animParam.beginVec = Vector2.New(x, y)

			FixedUpdateBeat:Add(self._trueAnimation, self)
			YuNuoTongXingController.instance:sendSetPiece(self._activityId, id)
		else
			self._animParam.endVec = Vector2.New(x, y)

			FixedUpdateBeat:Add(self._falseAnimation, self)
		end
	end
end

function YunuotongxingpuzzleView:_OnDragSeat(eventData)
	if self._dragFlag then
		self._dragGo.transform.position = uGuiUtil.GetTouchWorldPosition()
	end
end

function YunuotongxingpuzzleView:_trueAnimation()
	if self._animParam.animTime <= 1 then
		local vec = Vector2.Lerp(self._animParam.beginVec, self._animParam.endVec, self._animParam.animTime)

		Framework.TransformUtil.SetAnchoredPos(self._dragGo:GetComponent(goutil.Type_RectTransform), vec.x, vec.y)

		self._animParam.animTime = self._animParam.animTime + 0.05
	else
		local newData = {}

		for i, v in ipairs(self._chipView:getData()) do
			if v ~= self._animParam.tarId then
				table.insert(newData, v)
			end
		end

		self._chipView:reloadData(newData)
		uGuiUtil.setGoGrayState(self._animParam.tarGo, false)

		local effect = UIEffectManager.instance:playEffect(self, "fx_ui_xinxiyamianban/fx_ui_xinxiya_jiemianxuanzhong.prefab", nil, nil, nil, false, nil, nil, function(_, eff)
			eff:setParent(self._animParam.tarGo.transform)
			eff:setScale(1)
			eff:setLocalPos()
		end)

		table.insert(self._effList, effect)
		goutil.destroy(self._dragGo)

		self._dragGo = nil
		self._dragFlag = false

		FixedUpdateBeat:Remove(self._trueAnimation, self)
	end
end

function YunuotongxingpuzzleView:_falseAnimation()
	if self._animParam.animTime <= 1 then
		local vec = Vector2.Lerp(self._animParam.endVec, self._animParam.beginVec, self._animParam.animTime)

		Framework.TransformUtil.SetAnchoredPos(self._dragGo:GetComponent(goutil.Type_RectTransform), vec.x, vec.y)

		self._animParam.animTime = self._animParam.animTime + 0.1
	else
		goutil.destroy(self._dragGo)

		self._dragGo = nil
		self._dragFlag = false

		FixedUpdateBeat:Remove(self._falseAnimation, self)
	end
end

function YunuotongxingpuzzleView:_openRankView()
	UIStateManager.instance:push(ViewName.GoddesscollectorRankView, 124007)
end

return YunuotongxingpuzzleView

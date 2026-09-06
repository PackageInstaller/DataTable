-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orixingjiang/view/OriginxingjiangextView.lua

module("logic.extensions.orixingjiang.view.OriginxingjiangextView", package.seeall)

local OriginxingjiangextView = class("OriginxingjiangextView", ViewComponent)

function OriginxingjiangextView:ctor()
	OriginxingjiangextView.super.ctor(self)
end

function OriginxingjiangextView:unbindEvents()
	OriginxingjiangextView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnHide)
	GameUtil.rmClickHandler(self._btnShow)
	self._btnTxtJump:RemoveClickListener()
end

function OriginxingjiangextView:bindEvents()
	OriginxingjiangextView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnHide, self._onClickHide, self)
	GameUtil.addClickHandler(self._btnShow, self._onClickShow, self)
	self._btnTxtJump:AddClickListener(self._onClicktxtJump, self)
end

function OriginxingjiangextView:buildUI()
	OriginxingjiangextView.super.buildUI(self)

	local go = self:getGo("info/emenyFmt")

	self._enemyList = {}

	for i = 1, 9 do
		self._enemyList[i] = {
			go = goutil.findChild(go, "teamEnemy/cell_" .. i),
			con = goutil.findChild(go, "teamEnemy/cell_" .. i .. "/icon"),
			itemGo = goutil.findChild(go, "teamEnemy/cell_" .. i .. "/item"),
			transconGo = goutil.findChild(go, "teamEnemy/cell_" .. i .. "/exclSptGo"),
			transIconGo = goutil.findChild(go, "teamEnemy/cell_" .. i .. "/exclSptGo/exclIcon")
		}
	end

	self._btnHide = self:getGo("info/btnHide")
	self._showGo = self:getGo("showGo")
	self._btnShow = self:getGo("showGo/btnShow")
	self._txtRule = self:getTxt("info/txtRule")
	self._infoGo = self:getGo("info")
	self._goTopDesc = self:getGo("topDesc")
	self._txtTopDesc = self:getTxt("topDesc/txtDesc")
	self._btnTxtJump = self:getBtn("topDesc/txtJump")
	self._transcellGo = self:getGo("info/transcell")
	self._transcellMoveGo = self:getGo("info/transcellmove")
	self._transpetconGo = self:getGo("info/transpetcon")

	goutil.setActive(self._transcellGo, false)
	goutil.setActive(self._transcellMoveGo, false)

	self._transcellGos = {}
	self._layerUIGo = self:getGo("Nego_Left/layerUI")
	self._fmtPetBgGos = {}

	for i = 1, 9 do
		self._fmtPetBgGos[i] = goutil.findChild(self._layerUIGo, "item" .. i .. "/bg")
	end

	self._notPetTipsGo = self:getGo("info/emenyFmt/teamEnemy/notPetTips")
end

function OriginxingjiangextView:onExit()
	OriginxingjiangextView.super.onExit(self)

	for i, v in ipairs(self._enemyList) do
		MaterialMgr.resetAll(v.itemGo)
		MaterialMgr.resetAll(v.con)
		MaterialMgr.resetAll(v.transIconGo)
	end

	for i, v in ipairs(self._fmtPetBgGos) do
		local icon = goutil.findChild(v, "icon")

		MaterialMgr.resetAll(icon)
	end

	local moveCon = goutil.findChild(self._transcellMoveGo, "con")

	MaterialMgr.resetAll(moveCon)
end

function OriginxingjiangextView:onEnter()
	OriginxingjiangextView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.FormationChangeFinish, self._onFormationChangeFinish, self)

	self._fmtMo = self:getFirstParam()
	self._stageId = self._fmtMo._stageId
	self._activityId = self._fmtMo._activityId
	self._actCfg = OrixingjiangConfig.instance:getActCfg(self._activityId)
	self._stageCfg = self._fmtMo._stageCfg
	self._formation = self._fmtMo:getCurFormation()

	self:_updateUI()
	self:_onClickShow()
end

function OriginxingjiangextView:_updateUI()
	self._txtTopDesc.text = self._stageCfg.topDesc

	self:_refreshView()
end

function OriginxingjiangextView:_onFormationChangeFinish()
	self:_modifyTrans()
	self:_refreshView()
end

function OriginxingjiangextView:_onClickHide()
	GameUtil.SetActive(self._infoGo, false)
	GameUtil.SetActive(self._showGo, true)
end

function OriginxingjiangextView:_onClickShow()
	GameUtil.SetActive(self._infoGo, true)
	GameUtil.SetActive(self._showGo, false)
end

function OriginxingjiangextView:_modifyTrans()
	local positions = self._formation:GetPositions()
	local map = {}

	for posId, petId in ipairs(positions) do
		if petId > 0 then
			local transmogId = self._fmtMo:getTransmogId(petId)

			if transmogId and transmogId > 0 then
				map[petId] = transmogId
			end
		end
	end

	self._fmtMo:resetTransmogMap()

	for petId, transmogId in pairs(map) do
		self._fmtMo:setTransmogId(petId, transmogId)
	end
end

function OriginxingjiangextView:_refreshView()
	for i = 1, 9 do
		MaterialMgr.resetAll(self._enemyList[i].con)
		GameUtil.SetActive(self._enemyList[i].go, false)
	end

	local positions = self._formation:GetPositions()
	local upPetCnt = 0

	for posId, petId in ipairs(positions) do
		if petId > 0 then
			upPetCnt = upPetCnt + 1

			local petMo = self._fmtMo:getCurFormation():_getPet(petId)

			GameUtil.setLocalScale(self._enemyList[posId].con, 0.8, 0.8, 0.8)

			local proxy = MaterialMgr.setCellByMo(petMo, self._enemyList[posId].con)

			proxy.binder:setAutoTips(false)
			proxy.binder:setCallBack(function()
				local transmogId = self._fmtMo:getTransmogId(petId)

				if transmogId and transmogId > 0 then
					self._fmtMo:setTransmogId(petId, 0)
				end

				self:_refreshView()
			end)
			GameUtil.SetActive(self._enemyList[posId].go, true)

			local transmogId = self._fmtMo:getTransmogId(petId)

			if transmogId and transmogId > 0 then
				local transCfg = OrixingjiangConfig.instance:getTransmogCfg(self._activityId, transmogId)

				MaterialMgr.setIcon(self._enemyList[posId].transIconGo, MatType.Pet, transCfg.raceId)
				goutil.setActive(self._enemyList[posId].transconGo, true)
			else
				goutil.setActive(self._enemyList[posId].transconGo, false)
			end
		end
	end

	goutil.setActive(self._notPetTipsGo, upPetCnt <= 0)

	local transmogCount = OrixingjiangModel.instance:getAliveTransmogNum(self._activityId)
	local needCount = self._actCfg.passNeedAliveTransmog
	local color = needCount <= transmogCount and "green" or "red"

	self._txtRule.text = string.format("拖动到上阵精灵松开即完成选择，再次点击则取消当前累计幻化且存活(<color=%s>%s</color>/%s)", color, transmogCount, needCount)

	for i, v in ipairs(self._transcellGos) do
		goutil.setActive(v, false)
	end

	for i, transmogId in ipairs(self._stageCfg.canUseTransmogId) do
		if not self._fmtMo:isTransmog(transmogId) then
			local go = self._transcellGos[i]

			if not go then
				go = goutil.cloneAndSetParent(self._transcellGo, self._transpetconGo.transform)

				table.insert(self._transcellGos, go)
			end

			goutil.setActive(go, true)

			local transCfg = OrixingjiangConfig.instance:getTransmogCfg(self._activityId, transmogId)
			local goCon = goutil.findChild(go, "con")
			local goDrag = goutil.findChild(go, "drag")
			local btn = Framework.ButtonAdapter.GetFrom(go, "drag")
			local proxy = MaterialMgr.setCell(MatType.Pet, transCfg.raceId, goCon)

			self:_addMainOffetDrag(go, goDrag, transmogId)
			btn:AddClickListener(function()
				self:_onClickTransPet(transCfg.raceId)
			end)
		end
	end

	for i, v in ipairs(self._fmtPetBgGos) do
		local icon = goutil.findChild(v, "icon")
		local btn = Framework.ButtonAdapter.GetFrom(v, "icon")

		MaterialMgr.resetAll(icon)

		local hit = false
		local raceId = 0
		local petId = self._formation:GetPosition(i)

		if petId and petId > 0 then
			local transmogId = self._fmtMo:getTransmogId(petId)

			if transmogId and transmogId > 0 then
				local transCfg = OrixingjiangConfig.instance:getTransmogCfg(self._activityId, transmogId)

				MaterialMgr.setIcon(icon, MatType.Pet, transCfg.raceId)

				raceId = transCfg.raceId
				hit = true
			end
		end

		goutil.setActive(v, hit and raceId > 0)
		btn:AddClickListener(function()
			self:_onClickTransPet(raceId)
		end)
	end
end

function OriginxingjiangextView:_onClicktxtJump()
	self:_onClickShow()
end

function OriginxingjiangextView:_addMainOffetDrag(go, dragCon, transmogId)
	local moveCell = self._transcellMoveGo
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()
	local handleBegin = BeginDragHandler.Get(dragCon)

	handleBegin:AddLuaHandler(function(_go, eventData)
		self._isDrag = true

		local transCfg = OrixingjiangConfig.instance:getTransmogCfg(self._activityId, transmogId)
		local moveCon = goutil.findChild(moveCell, "con")

		MaterialMgr.resetAll(moveCon)

		if moveCon and transCfg then
			MaterialMgr.setCell(MatType.Pet, transCfg.raceId, moveCon)
		end

		goutil.setActive(moveCell, true)

		moveCell.transform.position = uGuiUtil.GetTouchWorldPosition()
	end)
	handleBegin:SetOnlyCallBackTop(true)

	local handleDrag = DragHandler.Get(dragCon)

	handleDrag:AddLuaHandler(function(_go, eventData)
		if not self._isDrag then
			return
		end

		moveCell.transform.position = uGuiUtil.GetTouchWorldPosition()
	end)
	handleDrag:SetOnlyCallBackTop(true)

	local handleEnd = EndDragHandler.Get(dragCon)

	handleEnd:AddLuaHandler(function(_go, eventData)
		self._isDrag = false

		goutil.setActive(moveCell, false)

		local dropPosId

		for i, v in ipairs(self._enemyList) do
			local petId = self._formation:GetPosition(i)

			if petId and petId > 0 then
				local isInRect = UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(v.go.transform, eventData.position, uiCamera)

				if isInRect then
					dropPosId = i

					break
				end
			end
		end

		if dropPosId then
			local petId = self._formation:GetPosition(dropPosId)

			if petId and petId > 0 then
				local petMo = self._fmtMo:getCurFormation():_getPet(petId)

				if petMo then
					self._fmtMo:setTransmogId(petId, transmogId)
					self:_refreshView()
				end
			end
		end
	end)
	handleEnd:SetOnlyCallBackTop(true)
end

function OriginxingjiangextView:_onClickTransPet(raceId)
	local tmpMo = FightingPowerPetMo.createPetByLevel(raceId, 1, 1)

	CommonTipsMgr.instance:showPetTips(tmpMo, true)
end

return OriginxingjiangextView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recastglory/view/RecastGloryshieldView.lua

module("logic.extensions.recastglory.view.RecastGloryshieldView", package.seeall)

local RecastGloryshieldView = class("RecastGloryshieldView", ViewComponent)
local GameState = {
	Play = 3,
	Enter = 1,
	Idle = 2,
	Success = 4
}

function RecastGloryshieldView:ctor()
	RecastGloryshieldView.super.ctor(self)
end

function RecastGloryshieldView:unbindEvents()
	RecastGloryshieldView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClose)
end

function RecastGloryshieldView:bindEvents()
	RecastGloryshieldView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function RecastGloryshieldView:buildUI()
	RecastGloryshieldView.super.buildUI(self)

	self._bg = self:getGo("bg")
	self._dun = self:getGo("dun")
	self._holyWater = self:getGo("holyWater")
	self._imgWater = self:getGo("holyWater/imgWater")
	self._holyWaterEffect = self:getGo("holyWater/effect")
	self._water = RecastGloryGameBase.New(self._holyWater)
	self._dirtyCol = self:getGo("dirtyCol")
	self._dirtyView = self:getGo("dirtyCol/dirtyView")
	self._dirtyCell = self:getGo("dirtyCol/dirtyCell")
	self._dirtyGroup = {}

	GameUtil.SetActive(self._dirtyCell, false)

	self._success = self:getGo("success")
	self._con = self:getGo("success/con")
	self._btnTip = self:getBtn("btnTip")
	self._btnClose = self:getBtn("btnClose")
end

function RecastGloryshieldView:onExit()
	RecastGloryshieldView.super.onExit(self)

	if self._dragTrigger then
		self._dragTrigger:RemoveBeginDragListener()
		self._dragTrigger:RemoveEndDragListener()
		self._dragTrigger:RemoveDragListener()
	end

	self._water:onExit()

	for _, v in ipairs(self._dirtyGroup) do
		self:_unLoadBigBg(v.mainGo)
		v.dirty:onExit()
	end

	self:_unLoadBigBg(self._imgWater)
	self:_unLoadBigBg(self._success)
	self:_unLoadBigBg(self._con)
	UIEffectManager.instance:stopEffect(self._dragEffect)
	UIEffectManager.instance:stopEffect(self._mainEffect)
	removetimer(self._dirtyCalculate, self)
end

function RecastGloryshieldView:onEnter()
	RecastGloryshieldView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._gameId = checknumber(params[1])
	self._successCallBack = params[2]

	if self._gameId <= 0 then
		self:close()

		return
	end

	self._gameShieldData = RecastGloryConfig.instance:getGloryGameShieldCfg(self._gameId)

	local key = string.format("%s_%s", ViewName.RecastGloryshieldView, self._gameId)

	local function firstTimeCallback()
		self:_openRuleView()
	end

	GameUtil.doCallbackWhenFirst(key, firstTimeCallback, nil)

	self._dragTrigger = Framework.UIDragTrigger.Get(self._holyWater.gameObject)
	self._dragTrigger.enabled = true

	self._dragTrigger:AddBeginDragListener(self._onBeginDragHolyWater, self)
	self._dragTrigger:AddEndDragListener(self._onEndDragHolyWater, self)
	self._dragTrigger:AddDragListener(self._onDragHolyWater, self)
	self:_loadBigBg(self._imgWater, self._gameShieldData.waterPath, true)
	self:_loadBigBg(self._bg, self._gameShieldData.bgPath)
	self:_loadBigBg(self._dun, self._gameShieldData.shieldPath, true)

	local dirtyDataList = RecastGloryConfig.instance:getGloryGameShieldDirtyDataList(self._gameId)
	local parentTran = self._dirtyView.transform
	local childGo = self._dirtyCell
	local children = GameUtil.getChildren(parentTran)

	for idx, mainGo in ipairs(children) do
		GameUtil.SetActive(mainGo, idx <= #dirtyDataList)
	end

	for idx, data in ipairs(dirtyDataList) do
		local cell = self._dirtyGroup[idx]

		if cell == nil then
			cell = {}

			if not children[idx] then
				local mainGo = goutil.cloneAndSetParent(childGo, parentTran, string.format("%s_%s", childGo.name, idx))

				cell.mainGo = mainGo
				cell.dirty = RecastGloryDrity.New(mainGo)
				self._dirtyGroup[idx] = cell
			end
		end

		self:_loadBigBg(cell.mainGo, data.picturePath, true)

		if not data.position then
			local pos = {}

			if not pos[3] then
				local px, py, scale = checknumber(pos[1]), checknumber(pos[2]), 1

				GameUtil.setLocalPos(cell.mainGo, px, py)
				GameUtil.setLocalScale(cell.mainGo, pos[3], pos[3], pos[3])

				if not data.rotation then
					if not data.rotation[3] then
						local rx, ry, rz = data.rotation[1] or 0, data.rotation[2] or 0, 0

						GameUtil.setLocalRotation(cell.mainGo, rx, ry, rz)
						GameUtil.SetActive(cell.mainGo, true)
						cell.dirty:onEnter()
					end
				end
			end
		end
	end

	self._water:onEnter()
	self:_init()
end

function RecastGloryshieldView:_init()
	self._gameState = GameState.Enter

	self:_showEffect(self.mainGO, true)

	self._gameState = GameState.Idle

	GameUtil.SetActive(self._dun, true)
	GameUtil.SetActive(self._success, false)
	self:_loadBigBg(self._success, self._gameShieldData.successBgPath, true)
	self:_loadBigBg(self._con, self._gameShieldData.successShieldPath, true)
	self:_effectChange()
end

function RecastGloryshieldView:_loadBigBg(bgGo, path, isSetNativeSize)
	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("ui/%s.png", path)

		local function func()
			if isSetNativeSize then
				bgGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		self:_unLoadBigBg(bgGo)
	end
end

function RecastGloryshieldView:_unLoadBigBg(bgGo)
	uGuiUtil.clearImage(bgGo)
end

function RecastGloryshieldView:_waterInDrity(id)
	local dirtyBox = self._dirtyGroup[id].dirty:getBoundingBox()
	local waterBox = self._water:getBoundingBox()

	if waterBox:intersects(dirtyBox) then
		self._dirtyGroup[id].dirty:_startWashing()
	else
		self._dirtyGroup[id].dirty:_stopWashing()
	end
end

function RecastGloryshieldView:_dirtyCalculate()
	if self._gameState < 4 then
		for id, v in ipairs(self._dirtyGroup) do
			self:_waterInDrity(id)
		end

		self._gameState = self:_washDirtySuccess()
	else
		self:_showSuccess()
		removetimer(self._dirtyCalculate, self)
	end
end

function RecastGloryshieldView:_washDirtySuccess()
	for _, v in ipairs(self._dirtyGroup) do
		if not v.dirty:isDisapear() then
			return GameState.Play
		end
	end

	return GameState.Success
end

function RecastGloryshieldView:_showSuccess()
	GameUtil.callBack(self._successCallBack)
	UIEffectManager.instance:stopEffect(self._dragEffect)
	GameUtil.SetActive(self._dun, false)
	GameUtil.SetActive(self._success, true)
	self:_showPet()
	FloatWordMgr.instance:show(self._gameShieldData.descSuccess)
end

function RecastGloryshieldView:_showPet()
	settimer(2, self._stroyPlay, self, false)
end

function RecastGloryshieldView:_stroyPlay()
	removetimer(self._stroyPlay, self)

	if self._gameShieldData.storyId > 0 then
		StoryController.instance:startStory(self._gameShieldData.storyId)
	end
end

function RecastGloryshieldView:_effectChange()
	UIEffectManager.instance:stopEffect(self._dragEffect)

	self._dragEffect = nil

	self:_showEffect(self._holyWaterEffect, true)
end

function RecastGloryshieldView:_showEffect(parent, loop)
	local path = "fx_ui_qirirenwu/fx_qirirenwu_pingmu.prefab"

	if self._gameState == GameState.Enter then
		path = "fx_ui_qirirenwu/fx_qirirenwu_pingmu.prefab"
	elseif self._gameState == GameState.Idle then
		path = "common/fx_ui_zhiyin_quan_03.prefab"
	elseif self._gameState == GameState.Play then
		path = self._gameShieldData.dragEffPath .. ".prefab"
	end

	local pmEff = UIEffectManager.instance:playEffect(self, path, parent, 0, 0, loop, nil, nil, nil, self)

	pmEff:setParent(parent.transform)
	pmEff:setLocalPos(0, 0, 0)
	pmEff:setScale(1)

	if self._gameState > 1 and self._gameState < 4 then
		self._dragEffect = pmEff
	else
		self._mainEffect = pmEff
	end
end

function RecastGloryshieldView:_onDragHolyWater(eventData)
	local pos = uGuiUtil.GetTouchWorldPosition()

	GameUtil.callBack(self._water:getBoundingBox(), self)

	self._holyWater.transform.position = pos

	GameUtil.SetActive(self._imgWater, false)
end

function RecastGloryshieldView:_onBeginDragHolyWater(eventData)
	if self._gameState < 4 then
		self._gameState = GameState.Play

		self:_effectChange()
		settimer(0, self._dirtyCalculate, self)
	end

	local trans = self._holyWater.transform

	self._initialPosX, self._initialPosY, self._initialPosZ = Framework.TransformUtil.GetLocalPos(trans, 0, 0, 0)
end

function RecastGloryshieldView:_onEndDragHolyWater(eventData)
	if self._gameState < 4 then
		self._gameState = GameState.Idle

		self:_effectChange()
		removetimer(self._dirtyCalculate, self)
	end

	local trans = self._holyWater.transform

	Framework.TransformUtil.SetLocalPos(trans, self._initialPosX, self._initialPosY, self._initialPosZ)
	GameUtil.SetActive(self._imgWater, true)
end

function RecastGloryshieldView:_onClickTip()
	self:_openRuleView()
end

function RecastGloryshieldView:_openRuleView()
	UIStateManager.instance:push(ViewName.RecastGloryruleView, self._gameShieldData.ruleId)
end

return RecastGloryshieldView

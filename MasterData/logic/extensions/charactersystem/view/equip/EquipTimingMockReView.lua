-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipTimingMockReView.lua

module("logic.extensions.charactersystem.view.equip.EquipTimingMockReView", package.seeall)

local M = class("EquipTimingMockReView", ViewComponent)
local json = require("cjson")

function M:buildUI()
	local imgMask1Go = goutil.findChild(self.mainGO, "imgMask1")

	goutil.addComponentOnce(imgMask1Go, goutil.Type_UIButton)

	self._btnImgMask = UIComponentType.ButtonAdapter(imgMask1Go)
	self._goDiceModel = self:getGo("timing_or_reset_show_view_choose_review_-804771387")
	self._diceModel = Astral.LuaComponentContainer.Add(self._goDiceModel, PhotoModel)

	self._diceModel:setModelLoadCallback(self._onModelLoaded, self)

	self._resultGo = goutil.findChild(self.mainGO, "content")
	self._itemView = Astral.LuaComponentContainer.Add(goutil.findChild(self._resultGo, "d6_attribute_item"), D6AttrComponentItem)

	goutil.setActive(self._resultGo, true)

	local faceGo = self:getGo("timing_or_reset_show_view_choose_review_422517471")

	self._faceinput = Astral.InputFieldAdapter.GetFrom(faceGo, "InputField")
	self._btnPre = self:getBtn("timing_or_reset_show_view_choose_review_-644181666")
	self._btnNext = self:getBtn("timing_or_reset_show_view_choose_review_202890974")
	self._btnDelete = self:getBtn("timing_or_reset_show_view_choose_review_-423937616")
	self._txtChoose = self:getText("timing_or_reset_show_view_choose_review_1460157792")
	self._txtPlaying = self:getText("timing_or_reset_show_view_choose_review_-1916103434")
	self._mockMod = 5
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._faceinput:AddOnValueChanged(self.onFaceValue, self)
	self._btnPre:AddClickListener(self.onClickPre, self)
	self._btnNext:AddClickListener(self.onClickNext, self)
	self._btnDelete:AddClickListener(self.onClickDelete, self)
	self._btnImgMask:AddClickListener(self._onClickImgMask, self)
end

function M:unbindEvents()
	self._faceinput:RemoveOnValueChanged()
	self._btnPre:RemoveClickListener()
	self._btnNext:RemoveClickListener()
	self._btnDelete:RemoveClickListener()
	self._btnImgMask:RemoveClickListener()
end

function M:onEnter()
	self._face = false

	self._diceModel:updateRes("jiaoshiqi3d/dice03/general/dice03-default.prefab", nil, UnityEngine.RenderTextureFormat.ARGBHalf, 2)
	self._diceModel:setCameraPosition(0, 15, -7.6)
	self._diceModel:setRotation(65, 0, 0)

	self._configData = EquipmentConfig.instance:getConfig(ConfigName.DiceClipInfo)
	self._configIndexData = EquipmentConfig.instance:getConfig(ConfigName.DiceClipInfoIndex)
end

function M:onExit()
	removetimer(self.mockMove, self)
	self._faceinput:SetText("")
end

function M:onExitFinished()
	GlobalDispatcher:dispatchEvent(EventType.CHECK_MONUMENTS_POP_EVENT)
end

function M:_onModelLoaded(inst, res)
	if not inst then
		return
	end

	Astral.GameObjectUtil.SetLayerRecursively(inst, SceneLayer.UI3D_Value)
	self._diceModel:setCameraCullingLayer(SceneLayer.UI3D_Value)

	self._diceTransform = self._diceModel:getTransform()

	Astral.TransformUtil.SetLocalScale(self._diceTransform, 3, 3, 3)
	LightMgr.instance:turnOn(LightName.UIEquip)
end

function M:onFaceValue()
	self._face = tonumber(self._faceinput:GetText())

	if self._face and self._face > 0 and self._face < 7 then
		self._curChoseIndex = 1

		local cur = self._configIndexData[self._face]
		local tt = json.encode(cur)

		self._txtChoose.text = "当前面数所有选择：" .. tt
		self._curIndex = cur[self._curChoseIndex]
		self._txtPlaying.text = "当前播放" .. tostring(cur[self._curChoseIndex])

		self:beginOnceMock()
	else
		ToolTipsMgr.showCharacterTopToast("请输入合法点数", CommEnum.CharacterTopToastIcon.Fail, 1)

		self._face = false
	end
end

function M:onClickPre()
	removetimer(self.mockMove, self)

	if not self._face then
		ToolTipsMgr.showCharacterTopToast("请先输入点数", CommEnum.CharacterTopToastIcon.Fail, 1)
	elseif self._curChoseIndex > 1 then
		self._curChoseIndex = self._curChoseIndex - 1

		local cur = self._configIndexData[self._face]

		self._curIndex = cur[self._curChoseIndex]
		self._txtPlaying.text = "当前播放" .. tostring(self._curIndex)

		self:beginOnceMock()
	else
		ToolTipsMgr.showCharacterTopToast("当前已是第一条", CommEnum.CharacterTopToastIcon.Fail, 1)
		self:beginOnceMock()
	end
end

function M:onClickNext()
	removetimer(self.mockMove, self)

	if not self._face then
		ToolTipsMgr.showCharacterTopToast("请先输入点数", CommEnum.CharacterTopToastIcon.Fail, 1)

		return
	end

	local faceIndexs = #self._configIndexData[self._face]

	if faceIndexs > self._curChoseIndex then
		self._curChoseIndex = self._curChoseIndex + 1

		local cur = self._configIndexData[self._face]

		self._curIndex = cur[self._curChoseIndex]
		self._txtPlaying.text = "当前播放" .. tostring(self._curIndex)

		self:beginOnceMock()
	else
		ToolTipsMgr.showCharacterTopToast("当前已是最后", CommEnum.CharacterTopToastIcon.Fail, 1)
		self:beginOnceMock()
	end
end

function M:onClickDelete()
	if false then
		ToolTipsMgr.showCharacterTopToast("当前点数筛选完毕", CommEnum.CharacterTopToastIcon.Fail, 1)
	end
end

function M:beginOnceMock()
	removetimer(self.mockMove, self)

	local face = self._face
	local pos = self._configData.pos[face]
	local qua = self._configData.qua[face]

	self._aniPos = pos[self._curIndex]
	self._aniQua = qua[self._curIndex]
	self._mockIndex = 1
	self._mockLerp = 0

	local frame = PlayerLocalStorageModel.instance:getGameFrame()
	local frameNum = SettingConst.KFrameNumberValue[frame]
	local time = frameNum and frameNum == 30 and 0.013 or 0.02

	settimer(time, self.mockMove, self, true)
end

function M:mockMove()
	local carPos = self._aniPos[self._mockIndex]
	local nextPos = self._aniPos[self._mockIndex + 1]
	local carQua = self._aniQua[self._mockIndex]
	local nextQua = self._aniQua[self._mockIndex + 1]
	local lerp = self._mockLerp / self._mockMod
	local pos = LerpPos(carPos, nextPos, lerp)
	local qua = LerpQua(carQua, nextQua, lerp)

	Astral.TransformUtil.SetPos(self._diceTransform, pos.x + 2000, pos.y, pos.z)
	Astral.TransformUtil.SetRotation(self._diceTransform, qua.x, qua.y, qua.z, qua.w)

	self._mockLerp = self._mockLerp + 1

	if self._mockLerp == self._mockMod then
		self._mockLerp = 0
		self._mockIndex = self._mockIndex + 1
	end

	if self._mockIndex >= #self._aniPos then
		removetimer(self.mockMove, self)
		goutil.setActive(self._goChoose, true)
	end
end

function LerpPos(pos1, pos2, lerp)
	local v1 = Vector3.New(pos1.x, pos1.y, pos1.z)
	local v2 = Vector3.New(pos2.x, pos2.y, pos2.z)

	return Vector3.Lerp(v1, v2, lerp)
end

function LerpQua(pos1, pos2, lerp)
	local q1 = Quaternion.New(pos1.x, pos1.y, pos1.z, pos1.w)
	local q2 = Quaternion.New(pos2.x, pos2.y, pos2.z, pos2.w)

	return Quaternion.Lerp(q1, q2, lerp)
end

function M:_onClickImgMask()
	self:back()
end

function M:onAniEnd()
	return
end

return M

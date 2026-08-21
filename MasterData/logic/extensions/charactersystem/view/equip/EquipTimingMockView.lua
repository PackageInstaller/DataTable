-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipTimingMockView.lua

module("logic.extensions.charactersystem.view.equip.EquipTimingMockView", package.seeall)

local M = class("EquipTimingMockView", ViewComponent)
local json = require("cjson")

function M:buildUI()
	local imgMask1Go = goutil.findChild(self.mainGO, "imgMask1")

	goutil.addComponentOnce(imgMask1Go, goutil.Type_UIButton)

	self._btnImgMask = UIComponentType.ButtonAdapter(imgMask1Go)
	self._goDiceModel = self:getGo("timing_or_reset_show_view_-804771387")
	self._diceModel = Astral.LuaComponentContainer.Add(self._goDiceModel, PhotoModel)

	self._diceModel:setModelLoadCallback(self._onModelLoaded, self)

	self._resultGo = goutil.findChild(self.mainGO, "content")
	self._itemView = Astral.LuaComponentContainer.Add(goutil.findChild(self._resultGo, "d6_attribute_item"), D6AttrComponentItem)

	goutil.setActive(self._resultGo, true)

	local faceGo = self:getGo("timing_or_reset_show_view_test_422517471")

	self._faceinput = Astral.InputFieldAdapter.GetFrom(faceGo, "InputField")
	self._btnMock = self:getBtn("timing_or_reset_show_view_test_-644181666")
	self._btnStopMock = self:getBtn("timing_or_reset_show_view_test_202890974")
	self._goChoose = self:getGo("timing_or_reset_show_view_test_-339676529")
	self._btnChoose = self:getBtn("timing_or_reset_show_view_test_1119224020")
	self._btnDelete = self:getBtn("timing_or_reset_show_view_test_1640974550")
	self._txtChoose = self:getText("timing_or_reset_show_view_test_322225966")
	self._goSave = self:getGo("timing_or_reset_show_view_test_-1305175696")
	self._btnSave = self:getBtn("timing_or_reset_show_view_test_-1637329271")
	self._btnDis = self:getBtn("timing_or_reset_show_view_test_613658508")
	self._btnClear = self:getBtn("timing_or_reset_show_view_test_-423937616")
	self._mockMod = 5
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._faceinput:AddOnValueChanged(self.onFaceValue, self)
	self._btnMock:AddClickListener(self.onClickMock, self)
	self._btnStopMock:AddClickListener(self.onClickStopMock, self)
	self._btnChoose:AddClickListener(self.onClickChoose, self)
	self._btnDelete:AddClickListener(self.onClickDelete, self)
	self._btnSave:AddClickListener(self._onClickSave, self)
	self._btnDis:AddClickListener(self._onClickDis, self)
	self._btnImgMask:AddClickListener(self._onClickImgMask, self)
	self._btnClear:AddClickListener(self._onClickClear, self)
end

function M:unbindEvents()
	self._faceinput:RemoveOnValueChanged()
	self._btnMock:RemoveClickListener()
	self._btnStopMock:RemoveClickListener()
	self._btnChoose:RemoveClickListener()
	self._btnDelete:RemoveClickListener()
	self._btnSave:RemoveClickListener()
	self._btnDis:RemoveClickListener()
	self._btnImgMask:RemoveClickListener()
	self._btnClear:RemoveClickListener()
end

function M:onEnter()
	self._face = false

	self._diceModel:updateRes("jiaoshiqi3d/dice03/general/dice03-default.prefab", nil, UnityEngine.RenderTextureFormat.ARGBHalf, 2)
	self._diceModel:setCameraPosition(0, 15, -7.6)
	self._diceModel:setRotation(65, 0, 0)

	self._chooseData = EquipmentConfig.instance:getConfig(ConfigName.DiceClipInfoIndex)

	goutil.setActive(self._goChoose, false)
	goutil.setActive(self._goSave, false)
end

function M:onExit()
	removetimer(self.mockMove, self)
	self._faceinput:SetText("")
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
		local choose = self._chooseData[self._face]
		local num = choose and #choose or 0

		self._txtChoose.text = "已选动画数量:" .. num
	else
		ToolTipsMgr.showCharacterTopToast("请输入合法点数", CommEnum.CharacterTopToastIcon.Fail, 1)

		self._face = false
	end
end

function M:onClickStopMock()
	removetimer(self.mockMove, self)
	goutil.setActive(self._goChoose, false)
end

function M:_onClickClear()
	removetimer(self.mockMove, self)
	goutil.setActive(self._goChoose, false)

	self._curIndex = 1
	self._chooseData[self._face] = {}

	local choose = self._chooseData[self._face]
	local num = choose and #choose or 0

	self._txtChoose.text = "已选动画数量:" .. num
end

function M:onClickMock()
	if not self._face then
		ToolTipsMgr.showCharacterTopToast("请先输入点数", CommEnum.CharacterTopToastIcon.Fail, 1)

		return
	end

	if not self._configData then
		self._configData = EquipmentConfig.instance:getConfig(ConfigName.DiceClipInfo)
	end

	local face = tonumber(self._face)
	local pos = self._configData.pos[face]

	self._diceIndexMax = #pos
	self._curIndex = 1

	self:beginOnceMock()
end

function M:onClickChoose()
	local chose = self._chooseData[self._face]
	local has = false

	if chose and #chose > 0 then
		for _, faced in ipairs(chose) do
			if faced == self._curIndex then
				has = true

				ToolTipsMgr.showCharacterTopToast("数据重复" .. faced, CommEnum.CharacterTopToastIcon.Fail, 1)

				break
			end
		end
	end

	if not has then
		table.insert(chose, self._curIndex)
	end

	local choose = self._chooseData[self._face]
	local num = choose and #choose or 0

	self._txtChoose.text = "已选动画数量:" .. num

	goutil.setActive(self._goChoose, false)

	if self._curIndex < self._diceIndexMax then
		self._curIndex = self._curIndex + 1

		self:beginOnceMock()
	else
		ToolTipsMgr.showCharacterTopToast("当前点数筛选完毕", CommEnum.CharacterTopToastIcon.Fail, 1)
	end
end

function M:onClickDelete()
	goutil.setActive(self._goChoose, false)

	if self._curIndex < self._diceIndexMax then
		self._curIndex = self._curIndex + 1

		self:beginOnceMock()
	else
		ToolTipsMgr.showCharacterTopToast("当前点数筛选完毕", CommEnum.CharacterTopToastIcon.Fail, 1)
	end
end

function M:beginOnceMock()
	removetimer(self.mockMove, self)

	if self._curIndex > self._diceIndexMax then
		ToolTipsMgr.showCharacterTopToast("当前点数筛选完毕", CommEnum.CharacterTopToastIcon.Fail, 1)

		return
	end

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

function M:save()
	local codejs = json.encode(self._chooseData)
	local codejs = string.gsub(codejs, "%[", "%{")
	local codejs = string.gsub(codejs, "%]", "%}")

	f = assert(io.open("Assets/Scripts/Lua/logic/config/diceclip/t_dice_clip_info_index.lua", "w"))

	f:write("module(\"logic.config.diceclip.t_dice_clip_info_index\", package.seeall)\nlocal configData =\n")
	f:write(codejs)
	f:write("\nreturn configData")
	f:close()
end

function M:_onClickDis()
	self:close()
end

function M:_onClickSave()
	self:save()
	self:close()
end

function M:_onClickImgMask()
	goutil.setActive(self._goSave, true)
end

function M:onAniEnd()
	return
end

return M

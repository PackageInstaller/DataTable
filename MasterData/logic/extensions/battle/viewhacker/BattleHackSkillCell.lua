-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewhacker/BattleHackSkillCell.lua

module("logic.extensions.battle.viewhacker.BattleHackSkillCell", package.seeall)

local M = class("BattleHackSkillCell", CellBaseComponent)
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
end

function M:Awake()
	self:onInit()
end

function M:onInit()
	self._nameTxt = goutil.findChildTextComponent(self._go, "txtName")
	self._idInputField = Astral.InputFieldAdapter.Get(goutil.findChild(self._go, "InputField"))
	self._clickBtn = ButtonAdapter.Get(goutil.findChild(self._go, "btn"))

	self._clickBtn:AddClickListener(self._onClickDeleteBtn, self)
	self._idInputField:AddOnEndEdit(self._onEndEditId, self)
end

function M:setData(skillNO, index)
	self._skillNO = skillNO
	self._index = index

	self:_refreshCell()
end

function M:setClickCallBack(func, handle)
	self._clickFunc = func
	self._handle = handle
end

function M:_refreshCell()
	self._idInputField:SetText(self._skillNO.code)

	local activeSkillCO = ActiveSkillConfig.instance:getActiveSkillCO(self._skillNO.code)

	if activeSkillCO then
		self._nameTxt.text = activeSkillCO.name
	else
		self._nameTxt.text = "错误Id"
	end
end

function M:_onClickDeleteBtn()
	if self._clickFunc then
		self._clickFunc(self._handle, self._index)
	end
end

function M:_onEndEditId()
	local code = checkint(self._idInputField:GetText())
	local activeSkillCO = ActiveSkillConfig.instance:getActiveSkillCO(code, true)

	self._nameTxt.text = activeSkillCO and activeSkillCO.name or ""

	if activeSkillCO then
		self._skillNO.code = code

		local ActiveSkillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(code)

		self._skillNO.type = ActiveSkillCOWrapper:getSkillType()
	else
		self._nameTxt.text = "错误Id"
	end
end

function M:OnDestroy()
	self._idInputField:RemoveOnEndEdit()
	self._clickBtn:RemoveClickListener()
end

return M

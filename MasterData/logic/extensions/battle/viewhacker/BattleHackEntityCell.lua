-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewhacker/BattleHackEntityCell.lua

module("logic.extensions.battle.viewhacker.BattleHackEntityCell", package.seeall)

local M = class("BattleHackEntityCell", CellBaseComponent)
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
	self._campTxt = goutil.findChildTextComponent(self._go, "txt1")
	self._nameTxt = goutil.findChildTextComponent(self._go, "txt2")
	self._idTxt = goutil.findChildTextComponent(self._go, "txt3")
	self._selectImg = goutil.findChildImageComponent(self._go, "Image1")
	self._clickBtn = ButtonAdapter.Get(goutil.findChild(self._go, "Image1"))

	self._clickBtn:AddClickListener(self._onClickBtn, self)
end

function M:setData(entity, index)
	self._entity = entity
	self._unit = BattleMgr.instance:getUnitMgr():getUnit(entity.id)
	self._index = index

	self:_refreshCell()
end

function M:setClickCallBack(func, handle)
	self._clickFunc = func
	self._handle = handle
end

function M:_refreshCell()
	local model = BattleMgr.instance:getModel()
	local selfCamp = model:getOperateCampId()
	local relationType = model:getCampRelation(selfCamp, self._unit.property:getCampId())

	if relationType == BattleEnum.CampRelation.ENEMY then
		self._campTxt.text = lang("tip_enemy_team")
	elseif relationType == BattleEnum.CampRelation.SAME then
		self._campTxt.text = lang("tip_player_team")
	elseif relationType == BattleEnum.CampRelation.FRIEND then
		self._campTxt.text = lang("tip_freind_team")
	end

	self._nameTxt.text = self._unit.property:getName()
	self._idTxt.text = self._unit.property:getEntityId()
end

function M:_onClickBtn()
	if self._clickFunc then
		self._clickFunc(self._handle, self._index)
	end
end

function M:setSelectStatus(status)
	if status then
		self._selectImg.color = Astral.ColorUtil.ParseColor("#DB5454")
	else
		self._selectImg.color = Astral.ColorUtil.ParseColor("#FFFFFF")
	end
end

function M:OnDestroy()
	self._clickBtn:RemoveClickListener()
end

return M

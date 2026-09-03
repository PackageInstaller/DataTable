-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/widget/EquipHpWidget.lua

EquipHpWidget = class("EquipHpWidget", BattleWidget, _M)

function EquipHpWidget:initialize(view)
	super.initialize(self, view)
	self:_setupView(view)
end

function EquipHpWidget:_setupView(view)
	self._label = view:getChildByFullName("label"):posite(10)

	view:setVisible(false)
end

function EquipHpWidget:shine()
	local view = self:getView()

	view:setVisible(true)
	view:stopAllActions()
	view:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeIn:create(0.5), cc.DelayTime:create(0.5), cc.FadeOut:create(0.5))))
end

function EquipHpWidget:init(info)
	self:shine()

	self._formation = {}

	local formation = info.formation

	if formation then
		for k, v in pairs(formation) do
			local id = v[2]

			self._formation[id] = k
		end
	end

	self._hpInfo = {}

	self._label:setString(Strings:get("BATTLE_RESIDUE_LIFE", {
		num = 100
	}))
end

function EquipHpWidget:refreshHp(id, hp, maxHp)
	local info = self._hpInfo[id]

	if info then
		info.hp = hp
		info.maxHp = maxHp or info.maxHp

		self:refreshLabel()
	end
end

function EquipHpWidget:addHeroHpInfo(id, cid, hp, maxHp)
	if self._formation[cid] then
		self._hpInfo[id] = self._hpInfo[id] or {}

		local info = self._hpInfo[id]

		info.hp = hp
		info.maxHp = maxHp or info.maxHp
	end
end

function EquipHpWidget:addMasterHpInfo(id, hp, maxHp)
	if self._hpInfo[self._preMaster] then
		self._hpInfo[self._preMaster] = nil
	end

	self._hpInfo[id] = self._hpInfo[id] or {}

	local info = self._hpInfo[id]

	info.hp = hp
	info.maxHp = maxHp or info.maxHp
	self._preMaster = id
end

function EquipHpWidget:refreshLabel()
	local hpAll = 0
	local maxHpAll = 0

	for k, v in pairs(self._hpInfo) do
		hpAll = hpAll + v.hp
		maxHpAll = maxHpAll + v.maxHp
	end

	self._label:setString(Strings:get("BATTLE_RESIDUE_LIFE", {
		num = (maxHpAll ~= 0 or nil) and math.floor(hpAll / maxHpAll * 100)
	}))
end

-- chunkname: @modules/logic/survival/model/map/SurvivalMapStepMo.lua

module("modules.logic.survival.model.map.SurvivalMapStepMo", package.seeall)

local SurvivalMapStepMo = pureTable("SurvivalMapStepMo")

function SurvivalMapStepMo:init(data)
	self.id = data.id
	self.type = data.type
	self.position = SurvivalHexNode.New(data.position.hex.q, data.position.hex.r)
	self.dir = data.position.dir
	self.paramInt = data.paramInt
	self.paramLong = data.paramLong
	self.panel = SurvivalPanelMo.New()

	self.panel:init(data.panel)

	self.hex = {}

	for k, v in ipairs(data.hex) do
		self.hex[k] = SurvivalHexNode.New(v.q, v.r)
	end

	self.unit = data.unit
	self.safeZone = data.safeZone
	self.hero = data.hero
	self.followTask = data.followTask

	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	self.extraBlock = {}

	if sceneMo then
		for _, v in ipairs(data.cells) do
			local mo = SurvivalHexCellMo.New()

			mo:init(v, sceneMo.mapType)
			table.insert(self.extraBlock, mo)
		end
	end

	self.items = GameUtil.rpcInfosToList(data.items, SurvivalBagItemMo)
end

return SurvivalMapStepMo

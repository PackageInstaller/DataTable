-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooegginfoView.lua

module("logic.extensions.zoo.view.ZooegginfoView", package.seeall)

local ZooegginfoView = class("ZooegginfoView", ViewComponent)

function ZooegginfoView:ctor()
	ZooegginfoView.super.ctor(self)
end

function ZooegginfoView:buildUI()
	ZooegginfoView.super.buildUI(self)

	self._closeBtn = self:getBtn("bg/close")
	self._generation = goutil.findChildTextComponent(self.mainGO, "bg/icon/generation/Text")
	self._name = goutil.findChildTextComponent(self.mainGO, "bg/icon/name")
	self._geneCell = self:getGo("bg/item_gene")
	self._normalGenes = self:getGo("bg/normal/sc")
	self._normalEmpty = self:getGo("bg/normal/empty")
	self._normalGeneView = ScrollerList.create(self._normalGenes, self._geneCell, GameUtil.handler(self._updateNormalCell, self))

	self._normalGeneView:regGetCellSize(GameUtil.handler(function(view, index)
		return 100, 30
	end, self))

	self._special = self:getGo("bg/special/sc")
	self._specialEmpty = self:getGo("bg/special/empty")
end

function ZooegginfoView:bindEvents()
	ZooegginfoView.super.bindEvents(self)
	self._closeBtn:AddClickListener(function()
		self:close()
	end, self)
end

function ZooegginfoView:unbindEvents()
	ZooegginfoView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function ZooegginfoView:destroyUI()
	ZooegginfoView.super.destroyUI(self)
end

function ZooegginfoView:onEnter()
	ZooegginfoView.super.onEnter(self)
	goutil.setActive(self._titleIcon, true)

	local openParam = self:getFirstParam()

	self._data = ZooConfig.instance:getAnimalById(openParam.raceId)
	self._data.generation = openParam.generation
	self._generation.text = self._data.generation .. "代"
	self._name.text = self._data.name

	if self._data.generation > 1 then
		local genelist = {
			[0] = {},
			{},
			{}
		}

		for i, v in ipairs(self._data.gene) do
			local geneInfo = ZooConfig.instance:getGene(v.geneId)

			if geneInfo then
				table.insert(genelist[geneInfo.type], geneInfo)
			end
		end

		self._normalGeneView:reloadData(genelist[1])

		for i, v in ipairs(genelist[2]) do
			local cellGo = goutil.cloneAndSetParent(self._geneCell, self._special.transform, i)
			local component = ItemGene.AddOnce(cellGo)
			local describe = ZooConfig.instance:getBenefitDescribe(v.benefitGene)

			if describe then
				v.info = describe.desc
			end

			component:setData(v)
			goutil.setActive(cellGo, true)
		end
	end

	goutil.setActive(self._normalEmpty, not (self._data.generation > 1))
	goutil.setActive(self._specialEmpty, not (self._data.generation > 1))
end

function ZooegginfoView:onEnterFinished()
	ZooegginfoView.super.onEnterFinished(self)
end

function ZooegginfoView:onExit()
	ZooegginfoView.super.onExit(self)
	self._normalGeneView:dispose()
end

function ZooegginfoView:onExitFinished()
	ZooegginfoView.super.onExitFinished(self)
end

function ZoodetailsView:_updateNormalCell(view, cell, data)
	local component = ItemGene.AddOnce(cell.gameObject)
	local describe = ZooConfig.instance:getBenefitDescribe(data.benefitGene)

	if describe then
		data.info = describe.desc
	end

	component:setData(data)
end

return ZooegginfoView

-- chunkname: @modules/logic/rouge2/map/view/choice/Rouge2_MapExploreChoiceItem.lua

module("modules.logic.rouge2.map.view.choice.Rouge2_MapExploreChoiceItem", package.seeall)

local Rouge2_MapExploreChoiceItem = class("Rouge2_MapExploreChoiceItem", Rouge2_MapNodeChoiceItem)

function Rouge2_MapExploreChoiceItem:_editableInitView()
	Rouge2_MapExploreChoiceItem.super._editableInitView(self)
end

function Rouge2_MapExploreChoiceItem:refreshBg()
	local lockBg = Rouge2_MapEnum.ExploreChoiceLockBg[self.selectType]
	local normalBg = Rouge2_MapEnum.ExploreChoiceNormalBg[self.selectType]
	local selectBg = Rouge2_MapEnum.ExploreChoiceSelectBg[self.selectType]

	UISpriteSetMgr.instance:setRouge7Sprite(self._imagelockbg, lockBg)
	UISpriteSetMgr.instance:setRouge7Sprite(self._imagenormalbg, normalBg)
	UISpriteSetMgr.instance:setRouge7Sprite(self._imageselectbg, selectBg)
end

function Rouge2_MapExploreChoiceItem:update(choiceId, nodeMo, index, checkRate)
	Rouge2_MapExploreChoiceItem.super.update(self, choiceId, nodeMo, index, checkRate)
	self:updatePos()
end

function Rouge2_MapExploreChoiceItem:updatePos()
	local itemPosX = 0
	local itemPosY = 0

	if not string.nilorempty(self.choiceCo.positionParam) then
		local positionParam = string.splitToNumber(self.choiceCo.positionParam, "#")

		itemPosX = positionParam[1] or 0
		itemPosY = positionParam[2] or 0
	else
		logError("肉鸽棋子选项未配置坐标 choiceId = %s", self.choiceId)
	end

	recthelper.setAnchor(self.tr, itemPosX, itemPosY)
end

function Rouge2_MapExploreChoiceItem:refreshSelectUI()
	Rouge2_MapExploreChoiceItem.super.refreshSelectUI(self)
	SLFramework.UGUI.GuiHelper.SetColor(self._imageselectshape, "#A39C2F")
	SLFramework.UGUI.GuiHelper.SetColor(self._txtselectdesc, "#6C4917")
end

return Rouge2_MapExploreChoiceItem

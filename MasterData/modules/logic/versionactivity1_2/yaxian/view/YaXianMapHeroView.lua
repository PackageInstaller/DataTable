-- chunkname: @modules/logic/versionactivity1_2/yaxian/view/YaXianMapHeroView.lua

module("modules.logic.versionactivity1_2.yaxian.view.YaXianMapHeroView", package.seeall)

local YaXianMapHeroView = class("YaXianMapHeroView", BaseView)

function YaXianMapHeroView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function YaXianMapHeroView:addEvents()
	return
end

function YaXianMapHeroView:removeEvents()
	return
end

function YaXianMapHeroView:onClickDetail()
	ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
		heroId = self.heroId
	})
end

function YaXianMapHeroView:_editableInitView()
	self.simageHeroIcon = gohelper.findChildSingleImage(self.viewGO, "window/role/icon")
	self.detailClick = gohelper.findChildClick(self.viewGO, "window/role/icon/detail")
	self.txtName = gohelper.findChildText(self.viewGO, "window/role/name")

	self.detailClick:AddClickListener(self.onClickDetail, self)
end

function YaXianMapHeroView:onUpdateParam()
	return
end

function YaXianMapHeroView:onOpen()
	self.maxTrialTemplateId = YaXianModel.instance:getMaxTrialTemplateId()
	self.heroId, self.skinId = YaXianModel.instance:getHeroIdAndSkinId()

	self:refreshUI()
end

function YaXianMapHeroView:refreshUI()
	local heroConfig = HeroConfig.instance:getHeroCO(self.heroId)

	self.txtName.text = heroConfig.name

	self:refreshHeroIcon()
end

function YaXianMapHeroView:refreshHeroIcon()
	local skinCo = SkinConfig.instance:getSkinCo(self.skinId)

	self.simageHeroIcon:LoadImage(ResUrl.getHeadIconMiddle(skinCo.retangleIcon))
end

function YaXianMapHeroView:onClose()
	return
end

function YaXianMapHeroView:onDestroyView()
	self.simageHeroIcon:UnLoadImage()
	self.detailClick:RemoveClickListener()
end

return YaXianMapHeroView

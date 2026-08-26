-- chunkname: @modules/logic/rouge/view/RougeFavoriteCollectionView.lua

module("modules.logic.rouge.view.RougeFavoriteCollectionView", package.seeall)

local RougeFavoriteCollectionView = class("RougeFavoriteCollectionView", BaseView)

function RougeFavoriteCollectionView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_fullbg")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_content")
	self._gobottom = gohelper.findChild(self.viewGO, "#go_bottom")
	self._btnlist = gohelper.findChildButtonWithAudio(self.viewGO, "#go_bottom/#btn_list")
	self._golistselected = gohelper.findChild(self.viewGO, "#go_bottom/#btn_list/#go_list_selected")
	self._btnhandbook = gohelper.findChildButtonWithAudio(self.viewGO, "#go_bottom/#btn_handbook")
	self._gohandbookselected = gohelper.findChild(self.viewGO, "#go_bottom/#btn_handbook/#go_handbook_selected")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeFavoriteCollectionView:addEvents()
	self._btnlist:AddClickListener(self._btnlistOnClick, self)
	self._btnhandbook:AddClickListener(self._btnhandbookOnClick, self)
end

function RougeFavoriteCollectionView:removeEvents()
	self._btnlist:RemoveClickListener()
	self._btnhandbook:RemoveClickListener()
end

function RougeFavoriteCollectionView:_btnlistOnClick()
	if self._listSelected then
		return
	end

	self.viewContainer:selectTabView(1)
	self:_setBtnListSelected(true)
end

function RougeFavoriteCollectionView:_btnhandbookOnClick()
	if self._listSelected == false then
		return
	end

	self.viewContainer:selectTabView(2)
	self:_setBtnListSelected(false)
end

function RougeFavoriteCollectionView:_setBtnListSelected(value)
	self._listSelected = value

	gohelper.setActive(self._golistselected, value)
	gohelper.setActive(self._gohandbookselected, not value)
end

function RougeFavoriteCollectionView:_editableInitView()
	self:_setBtnListSelected(true)
	gohelper.setActive(self._gobottom, RougeOutsideModel.instance:passedLayerId(RougeEnum.FirstLayerId))
end

function RougeFavoriteCollectionView:onUpdateParam()
	return
end

function RougeFavoriteCollectionView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.RougeFavoriteAudio6)
end

function RougeFavoriteCollectionView:onClose()
	if RougeFavoriteModel.instance:getReddotNum(RougeEnum.FavoriteType.Collection) > 0 then
		local season = RougeOutsideModel.instance:season()

		RougeOutsideRpc.instance:sendRougeMarkNewReddotRequest(season, RougeEnum.FavoriteType.Collection, 0)
	end
end

function RougeFavoriteCollectionView:onDestroyView()
	return
end

return RougeFavoriteCollectionView

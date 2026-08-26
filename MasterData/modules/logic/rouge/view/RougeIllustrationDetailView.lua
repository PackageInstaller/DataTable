-- chunkname: @modules/logic/rouge/view/RougeIllustrationDetailView.lua

module("modules.logic.rouge.view.RougeIllustrationDetailView", package.seeall)

local RougeIllustrationDetailView = class("RougeIllustrationDetailView", BaseView)

function RougeIllustrationDetailView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageFrameBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FrameBG")
	self._simageBottomBG = gohelper.findChildSingleImage(self.viewGO, "Bottom/#simage_BottomBG")
	self._txtName = gohelper.findChildText(self.viewGO, "Bottom/#txt_Name")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Bottom/#txt_Descr")
	self._txtPage = gohelper.findChildText(self.viewGO, "Bottom/#txt_Page")
	self._btnLeft = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Left")
	self._btnRight = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Right")
	self._goLeftTop = gohelper.findChild(self.viewGO, "#go_LeftTop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeIllustrationDetailView:addEvents()
	self._btnLeft:AddClickListener(self._btnLeftOnClick, self)
	self._btnRight:AddClickListener(self._btnRightOnClick, self)
end

function RougeIllustrationDetailView:removeEvents()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
end

function RougeIllustrationDetailView:_btnLeftOnClick()
	self._index = self._index - 1

	if self._index < 1 then
		self._index = self._num
	end

	self:_changePage()
end

function RougeIllustrationDetailView:_btnRightOnClick()
	self._index = self._index + 1

	if self._index > self._num then
		self._index = 1
	end

	self:_changePage()
end

function RougeIllustrationDetailView:_changePage()
	self._aniamtor:Play("switch", 0, 0)
	TaskDispatcher.cancelTask(self._delayUpdateInfo, self)
	TaskDispatcher.runDelay(self._delayUpdateInfo, self, 0.3)
end

function RougeIllustrationDetailView:_delayUpdateInfo()
	self:_updateInfo(self._list[self._index])
end

function RougeIllustrationDetailView:_editableInitView()
	self._txtNameEn = gohelper.findChildText(self.viewGO, "Bottom/#txt_Name/txt_NameEn")
	self._aniamtor = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
end

function RougeIllustrationDetailView:_initIllustrationList()
	local list = RougeFavoriteConfig.instance:getIllustrationList()

	self._list = {}

	for i, v in ipairs(list) do
		if RougeOutsideModel.instance:passedAnyEventId(v.eventIdList) then
			table.insert(self._list, v.config)
		end
	end

	self._num = #self._list
end

function RougeIllustrationDetailView:onOpen()
	self:_initIllustrationList()

	local mo = self.viewParam

	self._index = tabletool.indexOf(self._list, mo) or 1

	self:_updateInfo(mo)
end

function RougeIllustrationDetailView:_updateInfo(mo)
	self._mo = mo
	self._txtName.text = self._mo.name
	self._txtNameEn.text = self._mo.nameEn
	self._txtDescr.text = self._mo.desc
	self._txtPage.text = string.format("%s/%s", self._index, self._num)

	if not string.nilorempty(self._mo.fullImage) then
		self._simageFullBG:LoadImage(self._mo.fullImage)
	end

	local showNewFlag = RougeFavoriteModel.instance:getReddot(RougeEnum.FavoriteType.Illustration, self._mo.id) ~= nil

	if showNewFlag then
		local season = RougeOutsideModel.instance:season()

		RougeOutsideRpc.instance:sendRougeMarkNewReddotRequest(season, RougeEnum.FavoriteType.Illustration, self._mo.id)
	end
end

function RougeIllustrationDetailView:onClose()
	return
end

function RougeIllustrationDetailView:onDestroyView()
	TaskDispatcher.cancelTask(self._delayUpdateInfo, self)
end

return RougeIllustrationDetailView

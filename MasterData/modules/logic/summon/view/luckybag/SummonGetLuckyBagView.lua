-- chunkname: @modules/logic/summon/view/luckybag/SummonGetLuckyBagView.lua

module("modules.logic.summon.view.luckybag.SummonGetLuckyBagView", package.seeall)

local SummonGetLuckyBagView = class("SummonGetLuckyBagView", BaseView)

function SummonGetLuckyBagView:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg1")
	self._gocollection = gohelper.findChild(self.viewGO, "content/#go_collection")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonGetLuckyBagView:addEvents()
	return
end

function SummonGetLuckyBagView:removeEvents()
	return
end

function SummonGetLuckyBagView:_editableInitView()
	self._bgClick = gohelper.getClick(self.viewGO)

	self._bgClick:AddClickListener(self._onClickBG, self)
	gohelper.setActive(self._gocollection, false)

	self._simageIconList = self:getUserDataTb_()
end

function SummonGetLuckyBagView:onDestroyView()
	self._bgClick:RemoveClickListener()
end

function SummonGetLuckyBagView:onOpen()
	logNormal("SummonGetLuckyBagView onOpen")
	AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_wulu_lucky_bag_gain)
	self:refreshView()
end

function SummonGetLuckyBagView:onClose()
	return
end

function SummonGetLuckyBagView:refreshView()
	self.poolId = self.viewParam.poolId

	local luckyBagIdList = self.viewParam.luckyBagIdList

	if #luckyBagIdList <= 0 then
		logError("抽卡 福袋 id列表为空")

		return
	end

	gohelper.CreateObjList(self, self.onShowItem, luckyBagIdList, nil, self._gocollection)
end

function SummonGetLuckyBagView:onShowItem(itemGo, luckyBagId)
	local luckyBagCo = SummonConfig.instance:getLuckyBag(self.poolId, luckyBagId)

	if luckyBagCo then
		local txtName = gohelper.findChildTextMesh(itemGo, "txt_name")
		local txtNameEn = gohelper.findChildTextMesh(itemGo, "en")
		local simageIcon = gohelper.findChildSingleImage(itemGo, "#simage_icon")

		txtName.text = luckyBagCo.name
		txtNameEn.text = luckyBagCo.nameEn or ""

		table.insert(self._simageIconList, simageIcon)
		simageIcon:LoadImage(ResUrl.getSummonCoverBg(luckyBagCo.icon))
	end
end

function SummonGetLuckyBagView:_onClickBG()
	self:closeThis()

	if self._simageIconList and next(self._simageIconList) then
		for _, simageIcon in ipairs(self._simageIconList) do
			simageIcon:UnLoadImage()
		end

		tabletool.clear(self._simageIconList)

		self._simageIconList = nil
	end
end

return SummonGetLuckyBagView

-- chunkname: @modules/logic/sodache/view/inside/SodacheStatusView.lua

module("modules.logic.sodache.view.inside.SodacheStatusView", package.seeall)

local SodacheStatusView = class("SodacheStatusView", BaseView)

function SodacheStatusView:onInitView()
	self._txtEvilLv = gohelper.findChildTextMesh(self.viewGO, "left/layout_schedule/#btn_evil/#txt_level")
	self._goEvilBg = gohelper.findChild(self.viewGO, "left/layout_schedule/#btn_evil/bg")
	self._goEvilProgress = gohelper.findChild(self.viewGO, "left/layout_schedule/#btn_evil/#image_progressfg")
	self._txtActionPoint = gohelper.findChildTextMesh(self.viewGO, "left/layout/#btn_action/#txt_current")
	self._goscroll = gohelper.findChild(self.viewGO, "#scroll_bag")
	self._goscrolltitle = gohelper.findChild(self.viewGO, "#scroll_bag/Viewport/Content/title")
	self._goscrollcardgrid = gohelper.findChild(self.viewGO, "#scroll_bag/Viewport/Content/grid")
	self._goscrollspace = gohelper.findChild(self.viewGO, "#scroll_bag/Viewport/Content/space")
	self._goempty = gohelper.findChild(self.viewGO, "#go_empty")
	self._btnattr = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_ViewAll")

	gohelper.setActive(self._goscrolltitle, false)
	gohelper.setActive(self._goscrollcardgrid, false)
	gohelper.setActive(self._goscrollspace, false)
end

function SodacheStatusView:addEvents()
	self._btnattr:AddClickListener(self._onClickAttr, self)
end

function SodacheStatusView:removeEvents()
	self._btnattr:RemoveClickListener()
end

function SodacheStatusView:onOpen()
	self._txtActionPoint.text = SodacheUtil.getAttr(SodacheEnum.AttrId.ActionPoint)

	local evilLv = SodacheUtil.getAttr(SodacheEnum.AttrId.EvilValue)

	self._txtEvilLv.text = evilLv

	local isActive = evilLv > 0

	ZProj.UGUIHelper.SetColorAlpha(self._txtEvilLv, isActive and 1 or 0.5)
	ZProj.UGUIHelper.SetGrayscale(self._goEvilBg, not isActive)
	gohelper.setActive(self._goEvilProgress, isActive)

	self._firstLoadCount = 15

	local showTypes = {
		SodacheEnum.CardType.Status,
		SodacheEnum.CardType.Adventure,
		SodacheEnum.CardType.Ammo
	}

	self._mixScroll = MonoHelper.addNoUpdateLuaComOnceToGo(self._goscroll, SodacheMixScrollPart)

	self._mixScroll:setCellUpdateCallback(self._onCellUpdate, self)

	local datas = {}

	for i, v in ipairs(showTypes) do
		local list = self:getCardList(v)

		if #list > 0 then
			table.insert(datas, {
				list = list,
				title = luaLang("sodache_cardtype_" .. v),
				cardType = v
			})
		end
	end

	local isEmpty = #datas == 0
	local allDatas = {}
	local lineCardNum = 5

	for i, v in ipairs(datas) do
		table.insert(allDatas, SLFramework.UGUI.MixCellInfo.New(1, 80, {
			data = v,
			go = self._goscrolltitle
		}))

		local len = math.ceil(#v.list / lineCardNum)

		for j = 1, len do
			local mixData = {
				unpack(v.list, 1 + (j - 1) * lineCardNum, math.min(j * lineCardNum, #v.list))
			}

			table.insert(allDatas, SLFramework.UGUI.MixCellInfo.New(2, 350, {
				data = mixData,
				go = self._goscrollcardgrid
			}))

			if j ~= len then
				table.insert(allDatas, SLFramework.UGUI.MixCellInfo.New(3, 24, {
					data = {},
					go = self._goscrollspace
				}))
			end
		end

		if i ~= #datas then
			table.insert(allDatas, SLFramework.UGUI.MixCellInfo.New(3, 15.4, {
				data = {},
				go = self._goscrollspace
			}))
		end
	end

	self._mixScroll:setData(allDatas)
	gohelper.setActive(self._goempty, isEmpty)
end

function SodacheStatusView:_onCellUpdate(obj, type, data)
	if type == 1 then
		self:_createTitle(obj, data)
	elseif type == 2 then
		self:_createItem(obj, data)
	end
end

function SodacheStatusView:_createTitle(obj, data)
	local title = gohelper.findChildTextMesh(obj, "#titletxt")
	local imageType = gohelper.findChildImage(obj, "#image_icon")

	title.text = data.title

	UISpriteSetMgr.instance:setSodache2Sprite(imageType, "sodache_handbook_icon_" .. tostring(data.cardType))
end

function SodacheStatusView:_createItem(obj, data)
	local item = gohelper.findChild(obj, "#go_item")

	gohelper.CreateObjList(self, self._createItems, data, nil, item)
end

function SodacheStatusView:_createItems(obj, data, index)
	local cardGo = gohelper.findChild(obj, "go_card/sodache_carditem")
	local cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(cardGo, SodacheCardItem)

	cardItem:updateMo(data)
end

function SodacheStatusView:getCardList(cardType)
	local items = SodacheUtil.getItemsByCardType(cardType, SodacheEnum.BagType.Inside)
	local list = {}

	for i, v in ipairs(items) do
		if v.itemCo.disappear == 0 then
			table.insert(list, v:toCardMo())
		end
	end

	return list
end

function SodacheStatusView:_onClickAttr()
	ViewMgr.instance:openView(ViewName.SodacheRelicOverView)
end

return SodacheStatusView

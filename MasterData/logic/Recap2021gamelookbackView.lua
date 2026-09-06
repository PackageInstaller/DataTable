-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recap2021/view/Recap2021gamelookbackView.lua

module("logic.extensions.recap2021.view.Recap2021gamelookbackView", package.seeall)

local Recap2021gamelookbackView = class("Recap2021gamelookbackView", ViewComponent)

function Recap2021gamelookbackView:ctor()
	Recap2021gamelookbackView.super.ctor(self)
end

function Recap2021gamelookbackView:unbindEvents()
	Recap2021gamelookbackView.super.unbindEvents(self)
	self._btnOpen:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function Recap2021gamelookbackView:bindEvents()
	Recap2021gamelookbackView.super.bindEvents(self)
	self._btnOpen:AddClickListener(self._onClickbtnOpen, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function Recap2021gamelookbackView:buildUI()
	Recap2021gamelookbackView.super.buildUI(self)

	self._btnOpen = self:getBtn("btnOpen")
	self._btnClose = self:getBtn("btnClose")
	self._tablecellGo = self:getGo("tablecell")
	self._contentGo = self:getGo("tableview/Viewport/Content")
	self._contentTr = self._contentGo.transform

	goutil.setActive(self._tablecellGo, false)

	self._effectGo = self:getGo("effect")
end

function Recap2021gamelookbackView:destroyUI()
	for k, v in pairs(self._items) do
		uGuiUtil.clearImage(v.goIcon)
	end
end

function Recap2021gamelookbackView:onExit()
	Recap2021gamelookbackView.super.onExit(self)
	UIEffectManager.instance:stopEffect(self._effectHandler)
	GlobalDispatcher:removeListener(Recap2021Controller.PM_Recap21GetInfoRes, self._autoSetIndex, self)
end

function Recap2021gamelookbackView:onEnter()
	Recap2021gamelookbackView.super.onEnter(self)
	GlobalDispatcher:addListener(Recap2021Controller.PM_Recap21GetInfoRes, self._autoSetIndex, self)

	self._curViewDatas = Recap2021Config.instance:getEditionCfgs()
	self._contentTr.sizeDelta = Vector2.New(#self._curViewDatas * self:_getSpace(), 500)

	self:_setItems()
	self:_playEffect()
	Recap2021Agent.instance:sendPM_Recap21GetInfoReq()
end

function Recap2021gamelookbackView:_onClickbtnOpen()
	local data = self._curViewDatas[self._curIndex]

	if data then
		UIStateManager.instance:push(ViewName.Recap2021gamelookbacksubView, self._curViewDatas, self._curIndex)
	end
end

function Recap2021gamelookbackView:_onClickbtnClose()
	self._curIndex = false

	self:close()
end

function Recap2021gamelookbackView:_setItems()
	if not self._items then
		self._items = {}

		for i, v in ipairs(self._curViewDatas) do
			local go = goutil.cloneAndSetParent(self._tablecellGo, self._contentTr)
			local root = goutil.findChild(go, "root")
			local item = {
				txtName = goutil.findChildTextComponent(root, "txtName"),
				goIcon = goutil.findChild(root, "iconBg/icon"),
				goCon = goutil.findChild(root, "conBg"),
				goLine = goutil.findChild(root, "line"),
				btn = Framework.ButtonAdapter.Get(root)
			}

			self._items[i] = item

			goutil.setActive(go, true)
			uGuiUtil.setSpriteToImage(item.goIcon, nil, GameUrl.getCharacterIconUrl(v.iconName))

			local y = self:_getPosYNum(i % 3)
			local x = (i - 1) * self:_getSpace() + self:_getStartPosX()

			goutil.setActive(item.goLine, i ~= 1)

			local size, rotate = self:_getLineSizeAndRotate(i % 3)

			item.goLine.transform.sizeDelta = Vector2.New(size, 6)

			Framework.TransformUtil.SetLocalRotation(item.goLine.transform, 0, 0, rotate)
			Framework.TransformUtil.SetAnchoredPos(go.transform, x, y)

			item.txtName.text = v.versionName

			item.btn:AddClickListener(function()
				self:_switchItem(i)
			end)
		end
	end
end

function Recap2021gamelookbackView:_autoSetIndex()
	if not self._curIndex then
		for i, v in ipairs(self._curViewDatas) do
			if Recap2021Model.instance:isCanGainEditionIdPrize(v.editionId) then
				self:_switchItem(i)

				break
			end
		end

		if not self._curIndex then
			self:_switchItem(1)
		end
	end
end

function Recap2021gamelookbackView:_switchItem(index)
	if index > 1 then
		local flag = Recap2021Model.instance:isCanGainEditionIdPrize(index - 1)

		if flag then
			FloatWordMgr.instance:show("请先开启前置回忆")

			return
		end
	end

	FloatWordMgr.instance:show("点击开始回忆按钮，阅读一周年大事件内容吧~")

	self._curIndex = index

	for i, item in ipairs(self._items) do
		goutil.setActive(item.goCon, self._curIndex == i)
	end
end

function Recap2021gamelookbackView:_getStartPosX()
	return 100
end

function Recap2021gamelookbackView:_getSpace()
	return 300
end

function Recap2021gamelookbackView:_getPosYNum(i)
	if i == 0 then
		return -55, 323, 220
	elseif i == 1 then
		return -180, 255, 160
	elseif i == 2 then
		return -310, 260, 160
	end
end

function Recap2021gamelookbackView:_getLineSizeAndRotate(i)
	if i == 0 then
		return 323, 220
	elseif i == 1 then
		return 255, 160
	elseif i == 2 then
		return 260, 160
	end
end

function Recap2021gamelookbackView:_playEffect()
	local effName = "20220401/zhounianqingzongjie/fx_ui_zhounianzongjie_jiemian.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(1)
end

return Recap2021gamelookbackView

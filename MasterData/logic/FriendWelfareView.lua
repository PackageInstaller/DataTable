-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/view/FriendWelfareView.lua

module("logic.extensions.friend.view.FriendWelfareView", package.seeall)

local FriendWelfareView = class("FriendWelfareView", ViewComponent)

function FriendWelfareView:buildUI()
	FriendWelfareView.super.buildUI(self)

	self._goCell = self:getGo("cell")
	self._goTableview = self:getGo("tableview")
	self._tableview = ScrollerList.create(self._goTableview, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function FriendWelfareView:bindEvents()
	FriendWelfareView.super.bindEvents(self)
end

function FriendWelfareView:unbindEvents()
	FriendWelfareView.super.unbindEvents(self)
end

function FriendWelfareView:onEnter()
	FriendWelfareView.super.onEnter(self)

	local cfgs = FriendConfig.instance:getFetterWelfareCfgs()

	self._tableview:reloadData(cfgs)
end

function FriendWelfareView:onExit()
	FriendWelfareView.super.onExit(self)
	self._tableview:dispose()
end

function FriendWelfareView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)
	local isOpen = false
	local isFuncOpen = true

	if not string.nilorempty(data.startTime) then
		local timeNow = ServerTime.now()

		isOpen = timeNow > GameUtil.string2time(data.startTime)
	end

	if checkint(data.funcId) > 0 then
		isFuncOpen = FuncOpenModel.instance:getFuncIsOpen(data.funcId)
	end

	cell.desc.text = data.desc

	if not string.nilorempty(data.bgRes) then
		local path = langPara("ui/bigbg/friend/%s.png", data.bgRes)

		uGuiUtil.setSpriteToImage(cell.bg, uGuiUtil.SpriteType.BigBg, path)
	end

	goutil.setActive(cell.mask, not isOpen)
	goutil.setActive(cell.lock, isOpen and not isFuncOpen)
	GameUtil.addClickHandler(cell.go, GameUtil.handler(self._onClickTab, self, data))

	if isOpen and isFuncOpen then
		local redKey = ViewName.FriendWelfare .. "_" .. data.id
		local isShowFirst = checkint(GameUtil.getUserData(redKey)) <= 0

		RedPointController.instance:setRedPointInfo(redKey, isShowFirst)

		local arr = string.splitToNumber(data.redpoint or "", "#")

		table.insert(arr, redKey)
		RedPointController.instance:regRedPoint(cell.redpoint, unpack(arr))
	end
end

function FriendWelfareView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.bg = goutil.findChild(cell.go, "bg")
	cell.desc = goutil.findChildTextComponent(cell.go, "txtDesc")
	cell.redpoint = goutil.findChild(cell.go, "redpoint")
	cell.mask = goutil.findChild(cell.go, "mask")
	cell.lock = goutil.findChild(cell.go, "lock")

	goutil.setActive(cell.mask, false)
	goutil.setActive(cell.lock, false)
	goutil.setActive(cell.redpoint, false)
	RedPointController.instance:unregRedPoint(cell.redpoint)

	cell.desc.text = ""

	GameUtil.rmClickHandler(cell.go)
	uGuiUtil.clearImage(cell.bg)

	return cell
end

function FriendWelfareView:_onClickTab(data)
	local isOpen = false

	if not string.nilorempty(data.startTime) then
		local timeNow = ServerTime.now()

		isOpen = timeNow > GameUtil.string2time(data.startTime)
	end

	if isOpen and not string.nilorempty(data.jumpTo) then
		GotoMgr.gotoByString(data.jumpTo)
		GlobalDispatcher:dispatch(GlobalNotify.FriendWelfareRedPointUpdate)

		if (checkint(data.funcId) > 0 or nil) and FuncOpenModel.instance:getFuncIsOpen(data.funcId) then
			local redKey = ViewName.FriendWelfare .. "_" .. data.id

			GameUtil.saveUserData(redKey, 1)
			RedPointController.instance:setRedPointInfo(redKey, false)
		end
	end
end

return FriendWelfareView

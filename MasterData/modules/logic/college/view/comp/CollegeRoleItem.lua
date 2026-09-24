-- chunkname: @modules/logic/college/view/comp/CollegeRoleItem.lua

module("modules.logic.college.view.comp.CollegeRoleItem", package.seeall)

local CollegeRoleItem = class("CollegeRoleItem", LuaCompBase)

function CollegeRoleItem:init(go)
	self.go = go
	self.loader = PrefabInstantiate.Create(go)
	self._scale = 0.65
	self._scaleX = 1
end

function CollegeRoleItem:setScale(scale)
	self._scale = scale
end

function CollegeRoleItem:setScaleX(scaleX)
	if not scaleX then
		return
	end

	self._scaleX = scaleX
end

function CollegeRoleItem:setData(data)
	self.data = data

	self:setActorId(data.co.id)
end

function CollegeRoleItem:setName(name)
	self._name = name
end

function CollegeRoleItem:setActorId(actorId)
	self.co = lua_college_actor.configDict[actorId]

	if not self.co then
		return
	end

	self:setPath(self.co.pieceAsset)
end

function CollegeRoleItem:setPath(path)
	local fullPath = string.format("modules/college/scene/prefab/%s.prefab", path)

	if fullPath ~= self.loader:getPath() then
		self._anim = nil

		self.loader:dispose()

		if not string.nilorempty(fullPath) then
			self.loader:startLoad(fullPath, self._onLoaded, self)
		end
	end
end

local indexToHash = {}

setmetatable(indexToHash, {
	__index = function(t, k)
		local hash = UnityEngine.Animator.StringToHash(string.format("random_loop%d", k))

		rawset(t, k, hash)

		return hash
	end
})

function CollegeRoleItem:_onLoaded()
	if not self.loader then
		return
	end

	local go = self.loader:getInstGO()

	if not go then
		return
	end

	transformhelper.setLocalScale(go.transform, self._scale * self._scaleX, self._scale, self._scale)

	self._anim = gohelper.findComponentAnim(go)
	self._maxIndex = 0

	while self._anim and self._anim:HasState(0, indexToHash[self._maxIndex + 1]) do
		self._maxIndex = self._maxIndex + 1
	end

	if self._anim then
		self._anim:Play("open")
	end
end

function CollegeRoleItem:randomPlayAnim()
	if self._anim and self._maxIndex > 0 then
		local index = math.random(1, self._maxIndex)

		self._anim:Play(indexToHash[index])
	end
end

function CollegeRoleItem:setUI(ui, pool)
	self.ui = ui
	self.uiPool = pool
	self._uiFollower = gohelper.onceAddComponent(self.ui, typeof(ZProj.UIFollower))

	self._uiFollower:SetEnable(true)

	local mainCamera = CameraMgr.instance:getMainCamera()
	local uiCamera = CameraMgr.instance:getUICamera()
	local plane = ViewMgr.instance:getUIRoot().transform

	self._uiFollower:Set(mainCamera, uiCamera, plane, self.go.transform, 0, 0, 0, 0, 0)

	self._goleft = gohelper.findChild(ui, "left")
	self._goright = gohelper.findChild(ui, "right")
	self._txtleftdesc = gohelper.findChildTextMesh(ui, "left/#txt_desc")
	self._txtrightdesc = gohelper.findChildTextMesh(ui, "right/#txt_desc")
end

function CollegeRoleItem:playDialog(text, dir, callback, callobj)
	local name = self:getName()

	if not name then
		return
	end

	self._dir = dir or CollegeEnum.DialogDir.Left
	self._playEndCallback = callback
	self._playEndCallbackObj = callobj

	gohelper.setActive(self._goleft, self._dir == CollegeEnum.DialogDir.Left)
	gohelper.setActive(self._goright, self._dir == CollegeEnum.DialogDir.Right)

	if self._dir == CollegeEnum.DialogDir.Left then
		self._txtdesc = self._txtleftdesc or self._txtrightdesc
	end

	self._txtdesc.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("college_bubble"), name, "")
	self._descArr = GameUtil.getUCharArrWithoutRichTxt(text)
	self._curIndex = 0

	TaskDispatcher.runRepeat(self._onFrameShowTxt, self, 0.04, -1)
	gohelper.setActive(self.ui, true)
	self:randomPlayAnim()
end

function CollegeRoleItem:getName()
	return self._name or self.co and self.co.name
end

function CollegeRoleItem:_onFrameShowTxt()
	if self._curIndex >= #self._descArr then
		TaskDispatcher.cancelTask(self._onFrameShowTxt, self)
		TaskDispatcher.runDelay(self._delayHideUI, self, 2)

		return
	end

	self._curIndex = self._curIndex + 1
	self._txtdesc.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("college_bubble"), self:getName(), table.concat(self._descArr, "", 1, self._curIndex))
end

function CollegeRoleItem:_delayHideUI()
	gohelper.setActive(self.ui, false)

	local callback = self._playEndCallback
	local callobj = self._playEndCallbackObj

	self._playEndCallback = nil
	self._playEndCallbackObj = nil

	if callback then
		self._playEndCallback(callobj)
	end
end

function CollegeRoleItem:playExitAnim()
	TaskDispatcher.cancelTask(self._delayHideUI, self)
	TaskDispatcher.cancelTask(self._onFrameShowTxt, self)
	self:inPoolUI()

	local time = 0

	if self._anim then
		self._anim:Play("exit")
		self._anim:Update(0)

		time = self._anim:GetCurrentAnimatorStateInfo(0).length
	end

	TaskDispatcher.runDelay(self.destory, self, time)

	self._playEndCallback = nil
	self._playEndCallbackObj = nil
end

function CollegeRoleItem:destory()
	gohelper.destroy(self.go)
	self:inPoolUI()
	TaskDispatcher.cancelTask(self._onFrameShowTxt, self)
	TaskDispatcher.cancelTask(self._delayHideUI, self)
	TaskDispatcher.cancelTask(self.destory, self)

	self._playEndCallback = nil
	self._playEndCallbackObj = nil
end

function CollegeRoleItem:inPoolUI()
	if self.ui then
		if self.uiPool then
			gohelper.setActive(self.ui, false)
			table.insert(self.uiPool, self.ui)
		else
			gohelper.destroy(self.ui)
		end

		self.ui = nil
	end
end

function CollegeRoleItem:onDestroy()
	TaskDispatcher.cancelTask(self._onFrameShowTxt, self)
	TaskDispatcher.cancelTask(self._delayHideUI, self)
	TaskDispatcher.cancelTask(self.destory, self)

	self._playEndCallback = nil
	self._playEndCallbackObj = nil
end

return CollegeRoleItem

-- chunkname: @modules/common/others/UIBlockMgrExtend.lua

module("modules.common.others.UIBlockMgrExtend", package.seeall)

local UIBlockMgrExtend = class("UIBlockMgrExtend", LuaCompBase)
local ResPath = "ui/viewres/common/blockanimui.prefab"
local UIEndBlockPath = "UIRoot/TOP/UIEndBlock"
local WeakNetworkEffectLoopPath = "effects/prefabs/weak_network/weak_network_effect_loop.prefab"
local WeakNetworkEffectEndPath = "effects/prefabs/weak_network/weak_network_effect_end.prefab"
local Delay = 2
local WeakNetworkEndAnimationDuration = 1.2
local needCircleMv = true

UIBlockMgrExtend.CircleMvDelay = nil

function UIBlockMgrExtend.setNeedCircleMv(enable)
	if needCircleMv ~= enable then
		if canLogNormal then
			logNormal((enable and "显示菊花" or "隐藏菊花") .. debug.traceback("", 2))
		end

		needCircleMv = enable
	end
end

function UIBlockMgrExtend.preload(callback, callbackObj)
	UIBlockMgrExtend._callback = callback
	UIBlockMgrExtend._callbackObj = callbackObj
	UIBlockMgrExtend._loader = PrefabInstantiate.Create(UIBlockMgr.instance:getBlockGO())

	UIBlockMgrExtend._loader:startLoad(ResPath, UIBlockMgrExtend._onCallback)
end

function UIBlockMgrExtend._onCallback()
	if UIBlockMgrExtend._callback then
		UIBlockMgrExtend._callback(UIBlockMgrExtend._callbackObj)
	end

	UIBlockMgrExtend._callback = nil
	UIBlockMgrExtend._callbackObj = nil

	local blockGO = UIBlockMgr.instance:getBlockGO()
	local comp = MonoHelper.addNoUpdateLuaComOnceToGo(blockGO, UIBlockMgrExtend)

	comp:setGO(UIBlockMgrExtend._loader:getInstGO())

	UIBlockMgrExtend.instance = comp
end

function UIBlockMgrExtend.getEndUIBlockGo()
	UIBlockMgrExtend._endUIBlockGo = UIBlockMgrExtend._endUIBlockGo or gohelper.find(UIEndBlockPath)

	return UIBlockMgrExtend._endUIBlockGo
end

function UIBlockMgrExtend:setGO(go)
	self._loopGoWrapper = go
	self._endGoWrapper = gohelper.clone(self._loopGoWrapper, UIBlockMgrExtend.getEndUIBlockGo(), "endblockanimui")
	self.isPlay = false

	loadAbAsset(WeakNetworkEffectLoopPath, false, self._onLoopLoadCallback, self)
	loadAbAsset(WeakNetworkEffectEndPath, false, self._onEndLoadCallback, self)

	self._txt = gohelper.findChildText(go, "Text")
	self._clickCounter = 0

	SLFramework.UGUI.UIClickListener.Get(go.transform.parent.gameObject):AddClickListener(self._onClickBlock, self)
end

function UIBlockMgrExtend:setTips(str)
	if gohelper.isNil(self._txt) then
		return
	end

	self._txt.text = string.nilorempty(str) and "CONNECTING" or str
end

function UIBlockMgrExtend:_onClickBlock()
	self._clickCounter = self._clickCounter + 1

	if self._clickCounter == 30 then
		local keyList = {}

		for key, _ in pairs(UIBlockMgr.instance._blockKeyDict) do
			table.insert(keyList, key)
		end

		local unresponseList = ConnectAliveMgr.instance:getUnresponsiveMsgList()

		if #keyList == 1 and keyList[1] == UIBlockKey.MsgLock then
			if #unresponseList == 0 then
				UIBlockMgr.instance:endAll()
				logError("没有要等待的回包，关闭遮罩")

				return
			end

			if not isDebugBuild then
				return
			end
		end

		if isDebugBuild and tabletool.indexOf(keyList, UIBlockKey.MsgLock) then
			local unresponsiveMsg = ""

			for i, one in ipairs(unresponseList) do
				unresponsiveMsg = string.format("%s%s,", unresponsiveMsg, one.msg.__cname)
			end

			logError(string.format("Block Msg count=%d: %s", #unresponseList, unresponsiveMsg))
		end

		logError("BlockKeys: " .. table.concat(keyList, ","))
	end
end

function UIBlockMgrExtend:_onLoopLoadCallback(assetItem)
	if assetItem.IsLoadSuccess then
		assetItem:Retain()
		gohelper.clone(assetItem:GetResource(WeakNetworkEffectLoopPath), gohelper.findChild(self._loopGoWrapper, "network_wrapper"))
	end
end

function UIBlockMgrExtend:_onEndLoadCallback(assetItem)
	if assetItem.IsLoadSuccess then
		assetItem:Retain()
		gohelper.clone(assetItem:GetResource(WeakNetworkEffectEndPath), gohelper.findChild(self._endGoWrapper, "network_wrapper"))
	end
end

function UIBlockMgrExtend:_onAbLoadCallback(assetItem)
	if assetItem.IsLoadSuccess then
		assetItem:Retain()
		gohelper.clone(assetItem:GetResource(WeakNetworkEffectLoopPath), gohelper.findChild(self._loopGoWrapper, "network_wrapper"))
		gohelper.clone(assetItem:GetResource(WeakNetworkEffectEndPath), gohelper.findChild(self._endGoWrapper, "network_wrapper"))
	end
end

function UIBlockMgrExtend:onEnable()
	self._clickCounter = 0

	TaskDispatcher.cancelTask(self._onEndAnimationFinished, self)
	gohelper.setActive(UIBlockMgrExtend.getEndUIBlockGo(), false)
	gohelper.setActive(self._loopGoWrapper, false)

	if needCircleMv then
		if UIBlockMgrExtend.CircleMvDelay and UIBlockMgrExtend.CircleMvDelay > 0 then
			if not UIBlockMgrExtend.CircleMvDelay then
				local delay = Delay

				TaskDispatcher.runDelay(self._onDelayShow, self, delay)
			end
		end
	end
end

function UIBlockMgrExtend:onDisable()
	self._clickCounter = 0

	TaskDispatcher.cancelTask(self._onDelayShow, self)
	gohelper.setActive(self._loopGoWrapper, false)

	if not self.isPlay then
		return
	end

	if needCircleMv then
		gohelper.setActive(UIBlockMgrExtend.getEndUIBlockGo(), true)
		TaskDispatcher.runDelay(self._onEndAnimationFinished, self, WeakNetworkEndAnimationDuration)
	end
end

function UIBlockMgrExtend:_onDelayShow()
	if not needCircleMv then
		return
	end

	gohelper.setActive(self._loopGoWrapper, true)

	self.isPlay = true

	local keyList = {}

	for key, _ in pairs(UIBlockMgr.instance._blockKeyDict) do
		table.insert(keyList, key)
	end

	logNormal("BlockKeys: " .. table.concat(keyList, ","))
end

function UIBlockMgrExtend:_onEndAnimationFinished()
	self.isPlay = false

	TaskDispatcher.cancelTask(self._onEndAnimationFinished, self)
	gohelper.setActive(UIBlockMgrExtend.getEndUIBlockGo(), false)
end

return UIBlockMgrExtend

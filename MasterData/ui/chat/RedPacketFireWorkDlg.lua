-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Chat\\RedPacketFireWorkDlg.lua

local strClassName = "FireWorksEfxChild"
local FireWorksEfxChild = Class(strClassName, UIControls.Child)

function FireWorksEfxChild:ctor()
	self:initUI()
end

function FireWorksEfxChild:initUI()
	self.lazyEfx = UIControls.LazyEffectPlayer(self, "")
	self.lazyAudio = UIControls.LazyAudioPlayer(self, "")
end

function FireWorksEfxChild:playFireWorkEfx(index)
	local prefabIndex = index or math.random(7)
	local fireWorkPrefabPath = string.format("Effects/UI/efx_ui_fireworks_0%d.prefab", prefabIndex)
	local fireWorkAudioPath = string.format("Audios/SFX/UI/ui_fireworks%d.ogg", prefabIndex)

	self.lazyAudio:setAudioPath(fireWorkAudioPath)
	self.lazyEfx:playEffectByPath(fireWorkPrefabPath)
	self.lazyAudio:playAudio()
end

function FireWorksEfxChild:stopFireWorkEfx()
	self.lazyEfx:stopEffect()
end

function FireWorksEfxChild:destroy()
	self:stopFireWorkEfx()
end

local strClassName = "RedPacketFireWorkDlg"
local RedPacketFireWorkDlg = Class(strClassName, UIControls.Window)

function RedPacketFireWorkDlg:ctor(...)
	self:initUI()
end

function RedPacketFireWorkDlg:initUI(...)
	self.childFireWorkEfxList = {}
	self.curChildIndex = 1
end

function RedPacketFireWorkDlg:setData()
	return
end

function RedPacketFireWorkDlg:playEffect(isRandom)
	if self.curChildIndex == 8 then
		self.curChildIndex = 1
	end

	if not self.childFireWorkEfxList[self.curChildIndex] then
		local childFireWork = FireWorksEfxChild(self, "FireworksEfxPanel", "System/Chat/ChildFireworksEfx", nil, nil, true)

		if isRandom then
			childFireWork:playFireWorkEfx()
		else
			childFireWork:playFireWorkEfx(self.curChildIndex)
		end

		self.childFireWorkEfxList[self.curChildIndex] = childFireWork
	elseif isRandom then
		self.childFireWorkEfxList[self.curChildIndex]:playFireWorkEfx()
	else
		self.childFireWorkEfxList[self.curChildIndex]:playFireWorkEfx(self.curChildIndex)
	end

	self.curChildIndex = self.curChildIndex + 1
end

function RedPacketFireWorkDlg:stopAllEffect()
	if not self.childFireWorkEfxList then
		return
	end

	for index, child in ipairs(self.childFireWorkEfxList) do
		child:stopFireWorkEfx()
	end
end

function RedPacketFireWorkDlg:destroy()
	if not self.childFireWorkEfxList then
		return
	end

	for index, child in ipairs(self.childFireWorkEfxList) do
		child:destroy()
	end
end

return RedPacketFireWorkDlg

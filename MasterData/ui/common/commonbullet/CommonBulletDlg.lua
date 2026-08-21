-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\CommonBullet\\CommonBulletDlg.lua

local SingleRandomEquipTempleteTipsChild = require("UI.Common.Tips.SingleRandomEquipTempleteTipsChild")
local strClassName = "CommonBulletDlg"
local CommonBulletDlg = Class(strClassName, UIControls.Window)
local CommonBulletItem = require("UI/Common/CommonBullet/CommonBulletItem")
local ObjectPool = require("UI/Common/ObjectPool")
local CommonBulletUtils = require("UI/Common/CommonBullet/CommonBulletUtils")
local UIUtils = require("Framework.UI.UIUtils")

function CommonBulletDlg:ctor()
	self.defaultDuration = 15
	self.speedRandomRatio = 0.2
	self.textQueueCapacity = 100
	self.bullet_min_gap = 100
	self.bullet_max_gap = 200
	self.defaultRowCount = 7
	self.deltaTop = 94
	self.deltaBottom = 512
	self.screenPanel = UIControls.Panel(self, "BulletScreen")
	self.screenObj = self.screenPanel:getGameObject()
	self.bulletPrefabName = "System/AVG/AVGBulletItem"
	self.rowDuration = {}
	self.totalRowCount = self.defaultRowCount
	self.availableRowNum = self.defaultRowCount
	self.rowInfos = {}
	self.showingBullets = {}
	self.bulletCache = ObjectPool.New(self, "BulletScreen", self.bulletPrefabName, CommonBulletItem)
	self.typeShowRecord = {}
	self.screenTransform = nil
	self.cacheCapacity = 80
	self.cacheBullets = {}
	self.cacheStartIndex = 0
	self.cacheEndIndex = 0
	self.curCachedBulletsNum = 0

	self:initRowInfo()
end

function CommonBulletDlg:getRandomGap()
	return math.random(self.bullet_min_gap, self.bullet_max_gap)
end

function CommonBulletDlg:initRowInfo()
	local screenHeight = UIUtils.GetCurDesignHeight()

	self.screenHeight = screenHeight - self.deltaTop - self.deltaBottom
	self.screenWidth = UIUtils.GetCurDesignWidth()

	local startHeight = 0
	local rowDis = math.floor(self.screenHeight / self.totalRowCount)

	for i = 1, self.totalRowCount do
		local height = startHeight + (i - 1) * rowDis

		self.rowInfos[i] = self:createNewRowInfo(i, height)
		self.rowDuration[i] = self.defaultDuration + (math.random() * 2 - 1) * (self.speedRandomRatio * self.defaultDuration)
	end
end

function CommonBulletDlg:createNewRowInfo(index, height)
	local rowInfo = {}

	rowInfo.index = index
	rowInfo.posY = -height
	rowInfo.available = true

	return rowInfo
end

function CommonBulletDlg:addBullet(content, instant)
	if not content.text or content.text == "" then
		return
	end

	if self.availableRowNum > 0 and self.isActiveAndEnabled then
		local rowIndex = self:randomSelectRow()

		self:showBullet(content, rowIndex)
	else
		self:enQueue(content, instant)
	end
end

function CommonBulletDlg:enQueue(content, instant)
	if not content or content == "" then
		return
	end

	if self.curCachedBulletsNum == self.cacheCapacity then
		self.cacheBullets[self.cacheEndIndex] = content

		if instant then
			self.cacheBullets[self.cacheEndIndex], self.cacheBullets[self.cacheStartIndex] = self.cacheBullets[self.cacheStartIndex], self.cacheBullets[self.cacheEndIndex]
		end

		self.cacheEndIndex = (self.cacheEndIndex + 1) % self.cacheCapacity
	else
		self.cacheBullets[self.cacheEndIndex] = content

		if instant then
			self.cacheBullets[self.cacheEndIndex], self.cacheBullets[self.cacheStartIndex] = self.cacheBullets[self.cacheStartIndex], self.cacheBullets[self.cacheEndIndex]
		end

		self.cacheEndIndex = (self.cacheEndIndex + 1) % self.cacheCapacity
		self.curCachedBulletsNum = self.curCachedBulletsNum + 1
	end
end

function CommonBulletDlg:deQueue()
	if self.curCachedBulletsNum > 0 then
		self.curCachedBulletsNum = self.curCachedBulletsNum - 1

		local temp = self.cacheBullets[self.cacheStartIndex]

		self.cacheStartIndex = (self.cacheStartIndex + 1) % self.cacheCapacity

		return temp
	end

	return nil
end

function CommonBulletDlg:getCacheNum()
	return self.curCachedBulletsNum
end

function CommonBulletDlg:getStringTypePair(name, content)
	if name then
		return name .. ":" .. content
	else
		return content
	end
end

function CommonBulletDlg:showBullet(content, rowIndex)
	if not rowIndex or rowIndex < 1 or rowIndex > #self.rowInfos then
		return
	end

	local bullet = self.bulletCache:fetch()

	if bullet then
		local duration = self.rowDuration[rowIndex]
		local rowInfo = self.rowInfos[rowIndex]

		rowInfo.available = false
		self.availableRowNum = self.availableRowNum - 1

		local clickCallback
		local showCallback = Functor(self._bulletShowCallback, self, bullet, rowInfo)
		local moveCallback = Functor(self._bulletMoveCallback, self, bullet, rowInfo)
		local gap = self:getRandomGap()

		bullet:setData(content, gap, duration, rowInfo, clickCallback, showCallback, moveCallback)
		table.insert(self.showingBullets, bullet)

		bullet.showingIndex = #self.showingBullets

		bullet:setVisible(true)
	end
end

function CommonBulletDlg:showCacheBullet()
	if not self.isActiveAndEnabled then
		return
	end

	local content = self:deQueue()

	if content then
		local rowIndex = self:randomSelectRow()

		self:showBullet(content, rowIndex)
	end
end

function CommonBulletDlg:_bulletShowCallback(bullet, rowInfo)
	rowInfo.available = true
	self.availableRowNum = self.availableRowNum + 1

	self:showCacheBullet()
end

function CommonBulletDlg:_bulletClickCallback()
	return
end

function CommonBulletDlg:_bulletMoveCallback(bullet)
	bullet:stop()

	local prevIndex = bullet.showingIndex
	local lastIndex = #self.showingBullets

	self.showingBullets[prevIndex], self.showingBullets[lastIndex] = self.showingBullets[lastIndex], self.showingBullets[prevIndex]
	self.showingBullets[prevIndex].showingIndex = prevIndex

	table.remove(self.showingBullets, lastIndex)
	self:returnBullet(bullet)
end

function CommonBulletDlg:setState(state)
	self.state = state

	if not state then
		for _, bullet in pairs(self.showingBullets) do
			bullet:stop()
			self:returnBullet(bullet)
		end

		self:resetRowInfos()

		self.showingBullets = {}

		self:clearCache()
	end

	self.isActiveAndEnabled = state
end

function CommonBulletDlg:resetRowInfos()
	for _, rowInfo in pairs(self.rowInfos) do
		rowInfo.available = true
	end

	self.availableRowNum = self.defaultRowCount
end

function CommonBulletDlg:randomSelectRow()
	local random = math.random(1, self.availableRowNum)
	local count = 0

	for i = 1, self.totalRowCount do
		if self.rowInfos[i].available then
			count = count + 1

			if count == random then
				return i
			end
		end
	end

	return nil
end

function CommonBulletDlg:returnBullet(bullet)
	self.bulletCache:returnToPool(bullet)
end

function CommonBulletDlg:clearCache()
	self.cacheBullets = {}
	self.cacheStartIndex = 0
	self.cacheEndIndex = 0
	self.curCachedBulletsNum = 0
end

function CommonBulletDlg:destroy()
	self.bulletCache:destroy()

	self.bulletCache = nil

	CommonBulletDlg.super.destroy(self)
end

return CommonBulletDlg

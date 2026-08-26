-- chunkname: @modules/logic/versionactivity3_4/chg/model/ChgMapDragContext_MyData.lua

local _B = Bitwise

local function myAssert(...)
	return (...)
end

if isDebugBuild then
	if not _G.assert then
		local assert = myAssert
		local MyDPadInput = require("modules.logic.versionactivity3_4.chg.model.ChgMapDragContext_MyDPadInput")
		local MyFrameData = require("modules.logic.versionactivity3_4.chg.model.ChgMapDragContext_MyFrameData")
		local kCacheFrameCount = MyFrameData.kCacheFrameCount

		module("modules.logic.versionactivity3_4.chg.model.ChgMapDragContext_MyData", package.seeall)

		local ChgMapDragContext_MyData = class("ChgMapDragContext_MyData")

		function ChgMapDragContext_MyData:ctor(ctx)
			assert(kCacheFrameCount >= 3)

			self._ctx = ctx
			self._viewContainer = ctx._viewContainer
			self._myDPadInput = MyDPadInput.New()
			self._frameDataList = {}

			for i = 0, kCacheFrameCount do
				self._frameDataList[i] = MyFrameData.New(self)
			end

			self:clearAllFrames()
		end

		function ChgMapDragContext_MyData:_onNewFrame()
			self.frameCount = self.frameCount + 1
		end

		function ChgMapDragContext_MyData:curFrame()
			local curFrameIndex = self.frameCount % kCacheFrameCount

			return self._frameDataList[curFrameIndex]
		end

		function ChgMapDragContext_MyData:lastFrame()
			local lastFrameIndex = (self.frameCount + kCacheFrameCount - 1) % kCacheFrameCount

			return self._frameDataList[lastFrameIndex]
		end

		function ChgMapDragContext_MyData:cacheFrame()
			local cacheFrameIndex = (self.frameCount + kCacheFrameCount - 2) % kCacheFrameCount

			return self._frameDataList[cacheFrameIndex]
		end

		function ChgMapDragContext_MyData:clearAllFrames()
			for i = 0, kCacheFrameCount do
				self._frameDataList[i]:clear()
			end

			self.frameCount = 0
			self.editVisitedKeyDict = {}
			self.editEnergy = self._viewContainer:curEnergy()
			self.editLastSaved = self._ctx:lastUsedAndUsing()
			self.editWaitDragEnd = false
		end

		function ChgMapDragContext_MyData:_isZeroEnergy()
			local displayFrame = self:lastFrame()

			if displayFrame:isValid() then
				if displayFrame.detectFinalEnergy <= 0 then
					return true
				end
			elseif self.editEnergy <= 0 then
				return true
			end

			return false
		end

		function ChgMapDragContext_MyData:_isValidDrag()
			if self:_isZeroEnergy() then
				return false
			end

			return true
		end

		function ChgMapDragContext_MyData:onDragBegin(dragObj)
			self:resetToIdle()

			if not self:_isValidDrag() then
				if self:_isZeroEnergy() then
					GameFacade.showToast(ToastEnum.ChgOnNoEnergy)
				end

				return
			end

			self._ctx:execDragBegin(self)
		end

		function ChgMapDragContext_MyData:onDrag(dragObj)
			if not self:_isValidDrag() then
				return
			end

			if self.editWaitDragEnd then
				return
			end

			if self.frameCount <= kCacheFrameCount then
				self:_onDrag_CacheFrame(dragObj)
			else
				self:_onNewFrame()
				self:curFrame():snapshot(dragObj)
				self:_onDragImpl()
			end
		end

		function ChgMapDragContext_MyData:_onDrag_CacheFrame(dragObj)
			local dragInfo = dragObj:dragInfo()

			if dragObj:isDirNone() then
				return
			end

			local curLineItem = self._ctx:recentValidLineItem()

			if curLineItem then
				local curDir = curLineItem:getDir()
				local curEndItem = curLineItem:endItem()
				local isBlock = ChgEnum.isFlipDir(curDir, dragInfo.dirHorV)

				if isBlock and curEndItem then
					isBlock = not curEndItem:isEnd()
				end

				if isBlock then
					return
				end
			end

			self:_onNewFrame()
			self:curFrame():snapshot(dragObj)

			if self.frameCount == kCacheFrameCount then
				self._ctx:execDragging_FirstFrame(ChgDragBeginCmdFlow.New(self))
			end
		end

		function ChgMapDragContext_MyData:_onDragImpl()
			self._ctx:execDragging(ChgDraggingCmdFlow.New(self))
		end

		function ChgMapDragContext_MyData:onDragEnd(dragObj)
			self.editWaitDragEnd = false

			if self.frameCount <= kCacheFrameCount then
				return
			end

			self:_onDragEndImpl()
		end

		function ChgMapDragContext_MyData:_onDragEndImpl()
			self._ctx:execDragEnd(ChgDragEndCmdFlow.New(self))
		end

		function ChgMapDragContext_MyData:resetToIdle()
			self._ctx:resetToIdle()
			self:clearAllFrames()
		end

		function ChgMapDragContext_MyData:addVisit(item, eDir)
			if not item then
				return
			end

			local key = item:key()

			self.editVisitedKeyDict[key] = self.editVisitedKeyDict[key] or _B.set(self.editVisitedKeyDict[key], eDir)
		end

		function ChgMapDragContext_MyData:addVisitByLine(itemIndex, itemCount, lineDir, item)
			local isLast = itemIndex > 1 and itemIndex == itemCount
			local blockDir = isLast and ChgEnum.simpleFlipDir(lineDir) or lineDir

			self:addVisit(item, blockDir)

			if itemIndex > 1 and not isLast then
				self:addVisit(item, ChgEnum.Dir.All)
			end
		end

		function ChgMapDragContext_MyData:isVisited(item, lineDir)
			if not item then
				return false
			end

			if not lineDir then
				return false
			end

			local key = item:key()

			if not self.editVisitedKeyDict[key] then
				if _B.hasAny(self.editVisitedKeyDict[key], lineDir) then
					return true
				end

				if self._ctx:_roundMO():isVisited(key, lineDir) then
					return true
				end

				return false
			end
		end

		return ChgMapDragContext_MyData
	end
end

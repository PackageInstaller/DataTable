-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\HandBook\\HandBookArtifactGrid.lua

local strClassName = "HandBookArtifactGrid"
local HandBookArtifactGrid = Class(strClassName, UIControls.ArtifactGridLoop)

function HandBookArtifactGrid:ctor()
	self:_initUI()
end

function HandBookArtifactGrid:_initUI()
	return
end

function HandBookArtifactGrid:setArtifact(artifact)
	self:setObj(artifact)

	local geted = CurAvatar.handBookArtifactDic[artifact.id] ~= nil
	local bagHad = self.mWindow.idGrowthestArtifactDic and self.mWindow.idGrowthestArtifactDic[artifact.id] ~= nil

	if not geted then
		self.imgState2:setImage("Atlas/HandBookAtlas/HandBookAtlas", "TxtNotObtained")
	elseif self.mWindow.isShowGrowth and not bagHad then
		self.imgState2:setImage("Atlas/HandBookAtlas/HandBookAtlas", "TxtOnceOwned")
	end

	self.imgState2:setVisible(not geted or self.mWindow.isShowGrowth and not bagHad)
	self.imgIcon:setImageGray(not geted or self.mWindow.isShowGrowth and not bagHad)
	self.imgBgCareer:setImageGray(not geted or self.mWindow.isShowGrowth and not bagHad)
end

return HandBookArtifactGrid

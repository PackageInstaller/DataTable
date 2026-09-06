-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/challenge/view/ChallengeLoadBase.lua

module("logic.extensions.challenge.view.ChallengeLoadBase", package.seeall)

local ChallengeLoadBase = class("ChallengeLoadBase")

function ChallengeLoadBase:setView(view)
	self.viewComponent = view
end

function ChallengeLoadBase:onEnter(go)
	self:loadBigBg(go)
end

function ChallengeLoadBase:onExit()
	self.viewComponent = nil

	self:unloadBigBg()
end

function ChallengeLoadBase:getBigBgList()
	return nil
end

function ChallengeLoadBase:loadBigBg(mainGO)
	printWarn("加载图片！！！")

	local bgList = self:getBigBgList()

	if not bgList or #bgList < 1 then
		return
	end

	if not self._bigImages then
		self._bigImages = {}

		for i = 1, #bgList do
			local go = goutil.findChild(mainGO, bgList[i].goPath)

			if enableLog then
				local imageComp = go:GetComponent(goutil.Type_UIImage)

				if not goutil.isNil(imageComp.sprite) then
					printWarn("Sprite should not be referenced by BigImageBg GameObject! goPath=", bgList[i].goPath, mainGO.name)
				end
			end

			local img = Framework.ImageBigBG.Get(go)

			table.insert(self._bigImages, img)
		end
	end

	for i = 1, #self._bigImages do
		self._bigImages[i]:SetImage(langpath(bgList[i].imageUrl), nil)
	end
end

function ChallengeLoadBase:unloadBigBg()
	printWarn("卸载图片！！！")

	if not self._bigImages then
		return
	end

	for i = 1, #self._bigImages do
		self._bigImages[i]:ClearImage()
	end
end

return ChallengeLoadBase

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StotyModelCtrl.lua

module("logic.extensions.story.view.StotyModelCtrl", package.seeall)

local StotyModelCtrl = class("StotyModelCtrl")

function StotyModelCtrl:ctor(direction, charactor, imageNode, cam, uiCamera)
	self._imageNode = imageNode
	self._charactor = charactor
	self._uiCamera = uiCamera
	self._camera = cam
	self._direction = direction

	self:_initModels()
end

function StotyModelCtrl:onEnter()
	for i = 1, #self._models do
		self._models[i]:onEnter()
	end
end

function StotyModelCtrl:onExit()
	for i = 1, #self._models do
		self._models[i]:onExit()
	end
end

function StotyModelCtrl:setStory(story, storyConfig)
	local modelNum = #self._models

	self._models[1]:setStory(story, storyConfig)

	for i = 2, modelNum do
		self._models[i]:setObject(nil)
		self._models[i]:playEffect(nil)
	end
end

function StotyModelCtrl:setStories(stories, storyConfigs)
	local storyCount = #stories
	local modelNum = #self._models

	while modelNum < storyCount do
		local model = self:_createNewModel()

		model:onEnter()

		modelNum = modelNum + 1
	end

	local idx = 1

	for i = 1, storyCount do
		local cfg

		self._models[i]:setStory(stories[i], (storyConfigs or nil) and storyConfigs[i])

		idx = idx + 1
	end

	for i = idx, modelNum do
		self._models[i]:setObject(nil)
		self._models[i]:playEffect(nil)
	end
end

function StotyModelCtrl:onNotCurrShowing()
	for i = 1, #self._models do
		if self._models[i]:isDisappear_over() then
			self._models[i]._lastTransitionOut = self._models[i]._transitioningOut

			self._models[i]:setObject(nil)
			self._models[i]:playEffect(nil)
		else
			self._models[i]:setColor(0.6)
		end
	end
end

function StotyModelCtrl:setColor(color)
	for i = 1, #self._models do
		self._models[i]:setColor(color)
	end
end

function StotyModelCtrl:isLoadingRes()
	for i = 1, #self._models do
		if self._models[i]:isLoadingRes() then
			return true
		end
	end
end

function StotyModelCtrl:_initModels()
	self._models = {}

	self:_createNewModel()
end

function StotyModelCtrl:_createNewModel()
	local model = StoryViewModel.New(self._direction, self._charactor, self._imageNode, self._camera, self._uiCamera)

	table.insert(self._models, model)

	return model
end

function StotyModelCtrl:clearObjects(transition)
	for i = 1, #self._models do
		self._models[i]:setObject(nil, transition)
		self._models[i]:playEffect(nil)
	end
end

function StotyModelCtrl:hideObject()
	for i = 1, #self._models do
		self._models[i]:hideObject()
	end
end

return StotyModelCtrl

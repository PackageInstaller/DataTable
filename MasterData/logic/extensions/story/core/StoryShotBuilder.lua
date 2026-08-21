-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/StoryShotBuilder.lua

module("logic.extensions.story.core.StoryShotBuilder", package.seeall)

function BuildSequenceShots(graphAsset, binder, sequenceShots, storyBlackBoard)
	for k1, container in ipairs(graphAsset.containerNodes) do
		local shotId = container.ShotID
		local shot = StoryShot.New(shotId)

		table.insert(sequenceShots, shot)
		shot:Init(container, storyBlackBoard)
		graphAsset:FindAllOutEdgesByFromIdOutList(container.GUID, shot.shotEdges)

		for k3, trackAst in ipairs(container.tracksAssets) do
			local track = StoryFactor.CreateTrack(trackAst.actionType)

			track:Init(binder, trackAst, shot, storyBlackBoard)
			table.insert(shot.tracks, track)

			for k4, subNode in ipairs(trackAst.sections) do
				local section = StoryFactor.CreateSection(subNode.actionType)

				if section == nil then
					printWarn("无法创建section逻辑实例对象。请确保存在该类：", subNode.actionType)

					section = DefaultStorySection.New()
				end

				section:Init(binder, subNode, track, storyBlackBoard)
				table.insert(track.sections, section)
			end
		end
	end
end

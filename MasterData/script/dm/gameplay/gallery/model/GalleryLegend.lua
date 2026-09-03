-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/gallery/model/GalleryLegend.lua

require("dm.gameplay.gallery.model.GalleryLegendEffect")

GalleryLegend = class("GalleryLegend", objectlua.Object, _M)

GalleryLegend:has("_id", {
	is = "rw"
})
GalleryLegend:has("_tasks", {
	is = "rw"
})

function GalleryLegend:initialize(id, owner)
	super.initialize(self)

	self._id = id
	self._config = ConfigReader:requireRecordById("HerosLegendBase", id)
	self._tasks = {}

	self:initTasks()
end

function GalleryLegend:sync(data)
	for i, index in pairs(data) do
		if self._tasks[index] then
			self._tasks[index]:setState(true)
		end
	end
end

function GalleryLegend:initTasks()
	local targetHeroNum = table.nums(self:getHeroes())
	local num = 3

	for i = 1, num do
		local effect = self._config["Effect" .. i]
		local condition = self._config["Effect" .. i .. "Condition"]
		local legendEffect = GalleryLegendEffect:new(i)
		local data = {
			effect = effect,
			condition = condition,
			targetHeroNum = targetHeroNum,
			translateId = i == 1 and "Gallery_Legend_UI3" or "Gallery_Legend_UI4"
		}

		legendEffect:sync(data)
		table.insert(self._tasks, legendEffect)
	end
end

function GalleryLegend:getName()
	return Strings:get(self._config.Name)
end

function GalleryLegend:getSort()
	return self._config.Rank
end

function GalleryLegend:getNameColour()
	return self._config.NameColour
end

function GalleryLegend:getOutsideBG()
	return "asset/scene/galleryLegend/" .. self._config.OutsideBG .. ".jpg"
end

function GalleryLegend:getInsideBG()
	local backgroundId = ConfigReader:getDataByNameIdAndKey("BackGroundPicture", self._config.InsideBG, "Picture")

	return (backgroundId and backgroundId ~= "" or nil) and "asset/scene/" .. backgroundId .. ".jpg"
end

function GalleryLegend:getHeroes()
	if not self._heroes then
		self._heroes = {}

		for heroId, v in pairs(self._config.Heros) do
			local outside = {
				x = v[1][1],
				y = v[1][2],
				zOrder = v[1][3],
				scale = v[1][4]
			}
			local inside = {
				x = v[2][1],
				y = v[2][2],
				zOrder = v[2][3],
				scale = v[2][4],
				sort = v[2][5]
			}

			self._heroes[heroId] = {
				outside = outside,
				inside = inside
			}
		end
	end

	return self._heroes
end

local plotData = nil
local videoPools = {}
local videoInfo = nil
local effectInfos = nil
local currTime = 0
local lastVideoInfos = {}
local fade = nil
local stopList = {} --用于缓存需要关闭的异步创建的循环特效
local fatherView = nil

function Awake()
    fade = ComUtil.GetCom(videoParent,"ActionFade")
end

function Refresh(_data, _elseData,_view)
    fatherView = _view
    for i, v in pairs(lastVideoInfos) do
		if(not v.isLoop) then
            RecycleVideo(v.go)
			lastVideoInfos[i] = nil
		end
	end

    plotData = _data
    effectInfos = _elseData
    currTime = 0
    if plotData then
        videoInfo = plotData:GetVideoInfo()
        if(videoInfo) then
            for i, v in ipairs(videoInfo) do
                local videoDelay = v.delay or 0
                local parent = fatherView.effectLayer[v.layer or 2]
                if(v.id) then
                    local cfgVideo = Cfgs.PlotVideo:GetByID(v.id)
                    if(cfgVideo) then				
                        local plotID = plotData:GetID()						
                        FuncUtil:Call(function()
                            if(gameObject and not effectInfos[plotID]["Video"] and plotData) then
                                if(v.stop == 1) then --暂停循环
                                    if(lastVideoInfos[v.id] ~= nil) then
                                        if lastVideoInfos[v.id].go ~= nil then
                                            CSAPI.SetGOActive(lastVideoInfos[v.id].go, false)
                                            RecycleVideo(lastVideoInfos[v.id].go)
                                        else --缓存停止循环的列表
                                            stopList[v.id] = 1
                                        end
                                        lastVideoInfos[v.id] = nil
                                    end
                                elseif(not lastVideoInfos[v.id]) then
                                    lastVideoInfos[v.id] = {}
                                    Log(string.format("播放剧情特效，name:%s",cfgVideo.name))
                                    CreateVideo(cfgVideo.name, parent,function (video)
                                        if gameObject and video then
                                            local _info = {
                                                go = video.gameObject,
                                                isLoop = cfgVideo.loop ~= nil
                                            }
                                            lastVideoInfos[v.id] = _info

                                            if stopList[v.id] then --已经停止了循环，但刚刚创建出来，需要手动关闭特效
                                                CSAPI.SetGOActive(video.gameObject, false)
                                                RecycleVideo(video.gameObject)
                                                stopList[v.id] = nil
                                                lastVideoInfos[v.id] = nil
                                            end
                                        end
                                    end)
                                end									
                            end
                        end, nil, videoDelay * 1000)					
                        local _videoTime = videoDelay + cfgVideo.time
                        currTime = _videoTime > currTime and _videoTime or currTime
                    else
                        LogError("没有找到剧情视频数据！" .. v.id)
                    end
                end
            end
        end
    end
end     

--本次播放时间
function GetCurrTime()
    return currTime > 0 and currTime or nil
end

--获取
function CreateVideo(name, parent, callback)
    if name == nil or name == "" then
        return nil
    end
    if videoPools[name] and #videoPools[name] > 0 then
        local go = table.remove(videoPools[name],1)
        CSAPI.SetGOActive(go, true)
        CSAPI.SetParent(go,parent.gameObject)
        if callback then
            callback(go)
        end
        return
    end
    -- LogError(name)
    local path = "Effects/" .. name
    CSAPI.CreateGOAsync(path,0,0,0,parent,function (go)
        if callback then
            callback(go)
        end
    end)
end

--回收
function RecycleVideo(go)
    PlotTween.FadeOut(go,0.1,function ()
        videoPools = videoPools or {}
        if not IsNil(go) then
            local name = go.name
            videoPools[name] = videoPools[name] or {}
            CSAPI.SetGOActive(go,false)
            table.insert(videoPools[name], go)
        end
    end)
end

--跳过
function SkipVideo()
    if videoInfo then
        for i, v in ipairs(videoInfo) do
            if(v.id) then
                local cfgVideo = Cfgs.PlotVideo:GetByID(v.id)
                if(cfgVideo and cfgVideo.loop) then					
                    if(v.stop == 1) then --暂停循环
                        if(lastVideoInfos[v.id] ~= nil) then
                            if lastVideoInfos[v.id].go ~= nil then
                                CSAPI.SetGOActive(lastVideoInfos[v.id].go, false)	
                                RecycleVideo(lastVideoInfos[v.id].go)
                            else --缓存停止循环的列表
                                stopList[v.id] = 1
                            end	
                            lastVideoInfos[v.id] = nil
                        end
                    else
                        if(not lastVideoInfos[v.id]) then
                            lastVideoInfos[v.id] = {}
                            CreateVideo(cfgVideo.name, videoParent,function (video)
                                if gameObject then
                                    local _info = {
                                        go = video.gameObject,
                                        isLoop = cfgVideo.loop ~= nil
                                    }
                                    lastVideoInfos[v.id] = _info

                                    if stopList[v.id] then --已经停止了循环，但刚刚创建出来，需要手动关闭特效
                                        CSAPI.SetGOActive(video.gameObject, false)
                                        RecycleVideo(video.gameObject)
                                        stopList[v.id] = nil
                                        lastVideoInfos[v.id] = nil
                                    end
                                end
                            end)
                        end
                    end
                end
            end
        end
    end
end
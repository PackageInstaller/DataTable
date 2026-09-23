-- require_ex.lua

-- 判断是否可以更新的值
function IsUseNewReloadVal(oType, key, oVal, nVal)
    if oType == 'function' and string.sub(key, 1, 2) ~= '__' and oVal ~= nVal then
        return true
    end

    return false
end

-- 重新加载文件
function require_ex(filename)
    local old_content = nil
    if package.loaded[filename] then
        -- 把旧的模块保存起来
        old_content = package.loaded[filename]
        -- 然后package.loaded[filename]赋空
        package.loaded[filename] = nil
    end

    -- pcall下执行require
    local ok, err = pcall(require, filename)
    if not ok then
        --热更失败，将旧值赋回去
        if LogWarning then
            LogError('require_ex ' .. filename .. ' fail err msg: ' .. err)
        end
        package.loaded[filename] = old_content
        return false
    end

    -- 这里处理那些文件末尾会返回 return 一个table的文件
    if type(old_content) == 'table' then
        -- print("filename:", filename, Loader:IsReplaceFile(filename))
        -- ASSERT(false)

        if Loader:IsReplaceFile(filename) then
            for k, v in pairs(err) do
                old_content[k] = v
                --err[k] = nil
            end
        else
            for k, v in pairs(err) do
                local oVal = old_content[k]
                if oVal then
                    if IsUseNewReloadVal(type(oVal), k, oVal, v) then
                        LogDebug('IsUseNewReloadVal replace old:%s, %s, %s', k, oVal, v)
                        old_content[k] = v
                        --err[k] = nil
                    end
                else
                    LogDebug('IsUseNewReloadVal new:%s, %s, %s', k, oVal, v)
                    old_content[k] = v
                    --err[k] = nil
                end
            end
        end

        -- LogTable(old_content, 'old_content:' .. filename)
        package.loaded[filename] = old_content
    end

    if LogInfo then
        LogInfo('require_ex ' .. filename .. ' seccess.')
    end
    return true
end

-- 热更文件
function ReloadLua(nFile)
    -- 截取文件名称
    local len = string.len(nFile)

    local moduleName = ''
    for i = len, 1, -1 do
        local char = string.sub(nFile, i, i)
        if char == '.' then
            moduleName = string.sub(nFile, i + 1, len)
            break
        end
    end

    if string.len(moduleName) == 0 then
        moduleName = nFile
    end

    LogInfo('Reload, path: %s, file:%s', nFile, moduleName)

    -- 不是需要替换的表才只更改其中的函数，配置表那些是直接替换的
    local hadLoadVals = {}
    if not Loader:IsReplaceFile(moduleName) then
        hadLoadVals = Loader:GetHadRegisterGobalVal(moduleName)
    end

    -- LogTable(hadLoadVals, "hadLoadVals:")

    local oldOrignModule = {}

    if hadLoadVals then
        LogInfo("hadLoadVals start[遍历 %s 注册的全局变量，重新加载前临时保存一份]", moduleName)
        -- 遍历这个文件注册的所有全局变量，保存一份
        local cnt = 0
        for key, oType in pairs(hadLoadVals) do
            cnt = cnt + 1
            if Loader:IsReplaceFile(key) then
                hadLoadVals[key] = nil
            else
                -- LogDebug("File %s, had %s type %s", moduleName, key, oType)
                oldOrignModule[key] = _G[key]
            end
        end
        LogInfo("hadLoadVals finish cnt:%s[遍历 %s 注册的全局变量，重新加载前临时保存一份]", cnt, moduleName)
    end

    -- LogTable(oldOrignModule, "oldOrignModule:")

    -- 重载
    if not require_ex(nFile) then
        return false
    end

    Loader:AddFileName(nFile)

    if hadLoadVals then
        -- 遍历一次重载后的值，将旧的值改变，然后呢
        for key, oType in pairs(hadLoadVals) do
            -- LogInfo("replace key:%s, type: %s", key, oType)

            local newModule = _G[key]
            local oldModule = oldOrignModule[key]

            -- 不用理 newModule, 因为这里不进去，newModule 就会保存在 _G 里面的了
            if oldModule then
                xpcall(
                    function()
                        local nType = type(newModule)
                        if oType ~= nType then
                            if key ~= '_' then
                                LogError(
                                    'ReloadLua(%s) key: %s new type: %s ~= old type: %s ?????? ',
                                    moduleName,
                                    key,
                                    nType,
                                    oType
                                )
                            end
        
                            _G[key] = oldModule
                        else
                            if oType == 'table' then
                                -- LogTable(newModule, "newModule[" .. key .. "]:")
                                -- LogTable(oldModule, "oldModule[" .. key .. "]:")
        
                                -- 不是全局对象才可以修改
                                for nTbKey, nTbVal in pairs(newModule) do
                                    local oTbVal = oldModule[nTbKey]
                                    if oTbVal then
                                        if IsUseNewReloadVal(type(oTbVal), nTbKey, oTbVal, nTbVal) then
                                            -- LogInfo("[Yes]File %s.%s.%s old:%s => new:%s update", nFile, key, nTbKey, oTbVal, nTbVal)
                                            oldModule[nTbKey] = nTbVal
                                            --newModule[nTbKey] = nil
                                        else
                                            -- LogInfo("[NO]File %s.%s.%s type %s ignore not update", nFile, key, nTbKey, oType)
                                        end
                                    else
                                        -- LogInfo("[Yes]File %s.%s.%s old:%s => new:%s add", nFile, key, nTbKey, oTbVal, nTbVal)
                                        -- 旧表没有的，就直接赋值过来
                                        oldModule[nTbKey] = nTbVal
                                        --newModule[nTbKey] = nil
                                    end
                                end
        
                                _G[key] = oldModule
                            elseif IsUseNewReloadVal(oType, key, oldModule, newModule) then
                                -- 函数类的直接替换就好
                                -- LogInfo("[Yes]File %s.%s old:%s => new:%s update", nFile, key, oldModule, newModule)
                            else
                                -- LogInfo("[NO]File %s.%s type %s ignore not update", nFile, key, oType)
                                _G[key] = oldModule
                            end
                        end
                    end
                    , XpcallCB
                )
            end
        end
    end

    return true
end

function ReloadFiles(filesArr)
    local rDiff = math.abs(CURRENT_TIME - Loader:PreReloadTime())
    if rDiff < 5 then
        LogInfo('ReloadRegisterFiles diff:%s  < 5  so quick, so ignore it!', rDiff)
        return
    end

    g_mapBufferLoaded = {}
    g_mapSkillLoaded = {}

    local sumCnt = 0
    local errCnt = 0
    local preTime = GCalHelp:Clock()
    local errFiles = {}

    for _, nFile in ipairs(filesArr) do
        -- LogDebug("")
        -- LogDebug("beg")
        -- TimerHelper:PrintTime(CURRENT_TIME, "CURRENT_TIME: " .. nFile .. ":")

        sumCnt = sumCnt + 1
        local isCallOk, isOk = xpcall(ReloadLua, XpcallCB, nFile)
        if not isCallOk or not isOk then
            errCnt = errCnt + 1
            table.insert(errFiles, nFile)
        end

        -- if IsRelease then
        --     if nFile ~= 'DBCreater.CreateTables' and nFile ~= 'DBCreater.CreateLogTables' then
        --         xpcall(ReloadLua, XpcallCB, nFile)
        --     end
        -- else
        --     xpcall(ReloadLua, XpcallCB, nFile)
        -- end

        -- TimerHelper:PrintTime(CURRENT_TIME, "CURRENT_TIME: " .. nFile .. ":")
        -- LogDebug("end")
        -- LogDebug("")
    end

    Loader:AfterLoad(true)
    LogInfo("")
    LogInfo('Cur Use Mem %s', collectgarbage('count') / 1000 .. 'M')
    Loader:PreReloadTime(CURRENT_TIME)

    LogInfo("热更完毕 总文件%s个 报错%s个 占cpu用时%s秒", sumCnt, errCnt, (GCalHelp:Clock() - preTime)/1000)
    LogInfo("报错文件列表:%s", table.tostring(errFiles))
    LogInfo("")
end

-- 批量热更
function ReloadRegisterFiles()
    -- 文件列表，重新记录，防止有新加文件
    local tmpAllFiles = Loader:GetRegisterFiles()
    --Loader:ResetRegisterFiles()

    ReloadFiles(tmpAllFiles)
end

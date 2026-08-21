--lua库安装依赖
-- luarocks install luasec
-- luarocks install luasocket
-- yum install openssl libssl-dev

local TestUpLoad = {}

local socket = require("socket.http")
local ltn12 = require("ltn12")
local json = require "json"
local fileName = "test_results.txt"
local webhook_key = "824a41bb-2f37-4133-a435-cd292844f456"


--重定向输出到文件
function TestUpLoad.run()
    local file = io.open(fileName, "w")
    local output_buffer = {}  -- 用于存储所有输出内容
    local summary_line = nil  -- 专门存储结果摘要行

    -- 备份原始输出函数
    local old_print = print
    local old_write = io.write

    -- 重定向输出函数
    print = function(...)
        local line = table.concat({...}, "\t")
        old_print(line)  -- 保留控制台输出

        -- 识别并提取结果摘要行
        if line:match("^Ran %d+ tests") then
            summary_line = line
        else
            table.insert(output_buffer, line)
        end
    end

    io.write = function(...)
        old_write(...)  -- 保留控制台输出
        table.insert(output_buffer, ...)  -- 写入缓冲区
    end

    -- 运行测试
    luaunit.LuaUnit.run()

    -- 恢复原始输出函数
    print = old_print
    io.write = old_write

    -- 将摘要行写入文件第一行，然后是其他内容
    if summary_line then
        file:write(summary_line .. "\n")
    end
    file:write(table.concat(output_buffer, "\n"))
    file:close()
end

--统计结果通知到企业微信
function TestUpLoad.resultUpLoadWX()
    os.execute("start /B curl.bat")
end

--上传文件到企业微信机器人
function TestUpLoad.send_wechat_media()
    local response = {}
    local url = string.format(
        "https://qyapi.weixin.qq.com/cgi-bin/webhook/upload_media?key=%s&type=file",
        webhook_key
    )
    local _, status, headers = socket.request{
        -- 必需参数
        url = url,  -- 请求URL(字符串)
        method = "POST",  -- HTTP方法(默认"GET")

        -- 头部信息
        headers = {
            ["Content-Type"] = "application/octet-stream",
            ["Content-Length"] = 162,  -- 必须与实际body长度一致
            ["User-Agent"] = "LuaSocket/1.0"
        },

        -- 重定向控制
        redirect = false,  -- 是否跟随重定向(默认true)
    }

    -- 结果处理
    if status == 200 then
        print("Success:", table.concat(response))
    else
        print("Error:", status)
        if headers then
            print("Response headers:")
            for k,v in pairs(headers) do print(k..": "..v) end
        end
    end

end

-- 文件上传函数
local function upload_to_wechat_robot(file_path)
    -- 1. 读取本地文件
    local file, err = io.open(file_path, "rb")
    if not file then
        return nil, "无法读取文件: " .. (err or "未知错误")
    end
    local file_content = file:read("*a")
    file:close()

    -- 2. 构建 multipart/form-data 请求体
    local boundary = "----------" .. tostring(math.random(10000, 99999))
    local header = {
        ["Content-Type"] = "multipart/form-data; boundary=" .. boundary,
    }

    local body = {
        "--" .. boundary,
        'Content-Disposition: form-data; name="media"; filename="' .. file_path:match("([^/\\]+)$") .. '"',
        "Content-Type: application/plain",
        "",
        file_content,
        "--" .. boundary .. "--",
        ""
    }

    local request_body = table.concat(body, "\r\n")
    local url = string.format("https://qyapi.weixin.qq.com/cgi-bin/webhook/upload_media?key=%s&type=file",webhook_key)

    local response = {}
    local https = require("ssl.https")
    local res, code, headers = https.request{
        method = "POST",
        url = url,
        headers = header,
        source = ltn12.source.string(request_body),
        sink = ltn12.sink.table(response),
        ssl_verify = "none",
    }
    local json_response = table.concat(response)

    -- 5. 处理响应
    if code ~= 200 then
        return nil, "HTTP 错误码: " .. tostring(code) .. json_response
    end

    response = json.decode(response[1])
    local errcode = response.errcode
    if errcode ~= 0 then
        return nil, json_response
    end

    return true, response.media_id
end

-- 文件上传函数
local function send_to_wechat_robot(media_id)
    if not media_id then
        return nil, "not media_id"
    end

    local header = {
        ["Content-Type"] = "application/json; charset=UTF-8",
    }

    local body = 
    {
        msgtype = "file",
        file = 
        {
            media_id = media_id,
        }
    }

    local url = string.format("https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=%s",webhook_key)

    local response = {}
    local https = require("ssl.https")
    local res, code, headers = https.request{
        method = "POST",
        url = url,
        headers = header,
        source = ltn12.source.string(json.encode(body)),
        sink = ltn12.sink.table(response),
        ssl_verify = "none",
    }
    local json_response = table.concat(response)
    print(json_response)
    -- 5. 处理响应
    if code ~= 200 then
        return nil, "HTTP 错误码: " .. tostring(code) .. json_response
    end

    response = json.decode(response[1])
    local errcode = response.errcode
    if errcode ~= 0 then
        return nil, json_response
    end

    return true
   
end

function TestUpLoad.upload_and_send_file(file_path)
    local suc, media_id = upload_to_wechat_robot(file_path)
    if suc then
        local suc, err = send_to_wechat_robot(media_id)
        if suc then
            print("Upload Success:", file_path)
        else
            print("Upload failed:", err)
        end
    else
        print("Upload failed:", media_id)
    end
end

-- 示例用法 --
-- local file_path = "./test-results.xml"
-- TestUpLoad.upload_and_send_file(file_path)


return TestUpLoad
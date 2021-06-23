//
//  DeleteFolderFunction.swift
//  GeotabMobileSDK
//
//  Created by Yunfeng Liu on 2021-01-04.
//

class DeleteFolderFunction: ModuleFunction{
    
    private let module: FileSystemModule
    init(module: FileSystemModule) {
        self.module = module
        super.init(module: module, name: "deleteFolder")
    }
    
    
    override func handleJavascriptCall(argument: Any?, jsCallback: @escaping (Result<String, Error>) -> Void) {
        module.queue.async {
            
            guard argument != nil else {
                jsCallback(Result.failure(GeotabDriveErrors.ModuleFunctionArgumentError))
                return
            }
            
            let filePath = argument as? String ?? ""
            
            guard let drvfsDir = self.module.drvfsDir else {
                jsCallback(Result.failure(GeotabDriveErrors.FileException(error: FileSystemModule.DRVS_DOESNT_EXIST)))
                return
            }
            
            do {
                try deleteFolder(fsPrefix: FileSystemModule.fsPrefix, drvfsDir: drvfsDir, path: filePath)
                jsCallback(Result.success("undefined"))
            } catch {
                jsCallback(Result.failure(error))
            }
            
        }
    }
    
}

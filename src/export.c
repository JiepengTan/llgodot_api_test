

#include "godot/gdextension_interface.h"
#include <stdio.h> // for printf

void test_callfn_GDExtensionInterfaceClassdbRegisterExtensionClassMethod(
    const GDExtensionInterfaceClassdbRegisterExtensionClassMethod fn,
    GDExtensionClassLibraryPtr p_library,
    GDExtensionConstStringNamePtr p_class_name,
    GDExtensionClassMethodInfo *p_method_info) {

    fn(p_library, p_class_name, p_method_info);
    if(p_method_info != NULL){
        printf("Method name: %s\n", p_method_info->name);
        GDExtensionInt paramsCount = 4;
        int return_value = 0;
        p_method_info->call_func(NULL, NULL, NULL, paramsCount, (GDExtensionVariantPtr)(&return_value),NULL);
        printf("Return value: %d\n", return_value);
    }
}
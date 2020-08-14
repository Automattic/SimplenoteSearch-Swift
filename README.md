# SimplenoteSearch

This Package implements Search API(s) required by Simplenote iOS and macOS:

### **Interfaces:**
Defines the properties a Note and Tag entity must implement, so that our NSPredicate API(s) can filter them properly.
Conformance is not mandatory nor enforced by the compiler, since, as per August 2020, NSPredicate does not support generics.

### **NSPredicate + Search:**
Extension methods capable of building NSPredicate instances, with the purpose of filtering Notes and Tags entities.

### **NSString + Search:**
Extension methods designed to aid in the search functionality.

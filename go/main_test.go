package main

import "testing"

func TestAdd(t *testing.T) {
	result := Add(2, 3)
	expected := 5

	if result != expected {
		t.Errorf("expected %d, got %d", expected, result)
	}
}

func TestAddNegative(t *testing.T) {
	result := Add(-1, -1)
	expected := -2

	if result != expected {
		t.Errorf("expected %d, got %d", expected, result)
	}
}
